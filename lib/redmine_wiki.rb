require 'mechanize'
require 'uri'

class RedmineWiki
  class IllegalName < StandardError; end

  attr_accessor :username, :password

  def initialize(url, options = {})
    url += '/' unless url.end_with?('/')
    @url = URI.parse(url)
    @agent = Mechanize.new
    @agent.pre_connect_hooks << lambda{|agent, request| request['accept'] = 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5' }
    @options = options
    @username = options[:username]
    @password = options[:password]
  end

  def get(page)
    url = get_url(page)
    access(url)
    fetch_text_from_edit_form
  end

  def update(page, body)
    url = get_url(page)

    access(url)
    post_text(body)
  end

  private
  # FIXME crawler class?

  def access(url)
    @agent.get(url)
    if in_login_url?
      login
      @agent.get(url.to_s)
    end
  end

  def fetch_text_from_edit_form
    page.at('textarea').text
  end

  def post_text(body)
    form = page.form_with(:id => 'wiki_form')
    form['content[text]'] = body
    form.submit
  end

  def assert_page(page)
    raise IllegalName unless /^\w+$/ =~ page
  end

  def get_url(page)
    assert_page(page)
    @url + "#{page}/edit"
  end

  def page
    @agent.page
  end

  def page_url
    page.url rescue nil
  end

  def in_login_url?
    !!page.form_with(:action => /login/)
  end

  def access_login_form
    @agent.get @url + '/login'
  end

  def submit_login
    loginform = page.form_with(:action => /login/)
    loginform.username = @username
    loginform.password = @password
    loginform.submit
  end

  def login
    access_login_form unless in_login_url?
    submit_login
  end

  def login_unless_logined
    # page access and...
    submit_login if in_login_url?
  end

end


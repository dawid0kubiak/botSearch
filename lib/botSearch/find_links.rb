class FindLinks
  def initialize
    @links = []
    @base_link = 'https://www.aldcarmarket.com/'
    @linki = []
    @browser = Selenium::WebDriver.for :phantomjs
    @browser.get 'https://www.aldcarmarket.com/'
  end

  def linki

    @browser.find_elements(:xpath, ".//*[@class='saleTitle']/a").each { |a| @linki << a.attribute('href')}
    @browser.quit
    @linki
  end
end
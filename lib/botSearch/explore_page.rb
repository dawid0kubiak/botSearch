class ExplorePage

  def search_car(cars_name_search, url)
    @browser = Selenium::WebDriver.for :phantomjs
    @browser.get url
    scroll_to_end_page
    cars = []
    @browser.find_elements(:xpath, ".//*[@class='carDetailsContainer']").each do |car|
      car_name = car.find_element(:xpath, ".//*[@class='details']/h2").text
      car_detalis = car.find_element(:xpath, ".//*[@class='details']")
      cars_name_search.each do |car_name_search|
      if car_name.upcase.include? car_name_search.upcase
        cars << url
        cars << car_detalis.text
        cars << '=============================================================================================='
      end
      end
    end
    @browser.quit
   cars
  end

  private
  def scroll_to_end_page
    totalItemCount = @browser.find_element(:xpath, ".//*[@id='totalItemCount']").attribute('value').to_i
    until totalItemCount <= @browser.find_elements(:xpath, ".//*[@class='carDetailsContainer']").count do
      @browser.execute_script("window.scrollTo(0, document.body.scrollHeight)")
    end
  end

end
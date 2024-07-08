require "selenium-webdriver"
require "csv"


base_url = "https://varieties.worldcoffeeresearch.org/arabica/varieties"
base_url2 = "https://varieties.worldcoffeeresearch.org/robusta/varieties"
csv_file = "lib/assets/coffee_varieties.csv"

# define the browser options
options = Selenium::WebDriver::Chrome::Options.new

# set a custom user agent
user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
options.add_argument("--user-agent=#{user_agent}")

# to run Chrome in headless mode
options.add_argument("--headless") # comment out in development

# create a driver instance to control Chrome with the specified options
driver = Selenium::WebDriver.for :chrome, options: options



# connect to the target page
driver.navigate.to base_url


# wait for rows to be loaded and rendered
sleep(5)

# select all HTML row elements
varieties = driver.find_elements(:css, ".theme-arabica")

csv_rows = []

varieties.map do |variety|
  new_row = ['Arabica']
  # variety link
  new_row.push(variety.find_element(:css, "a").attribute('href'))
  # variety name
  new_row.push(variety.find_element(:css, 'div a h3').text )
  # subvariety name
  new_row.push(variety.find_element(:css, 'div a span').text ) rescue new_row.push("")
  # variety description
  new_row.push(variety.find_element(:css, 'div p').text )

  csv_rows.push(new_row)
end

driver.navigate.to base_url2

# wait for rows to be loaded and rendered
sleep(5)

# select all HTML row elements
varieties = driver.find_elements(:css, ".theme-robusta")

varieties.map do |variety|
  new_row = ['Robusta']
  # variety link
  new_row.push(variety.find_element(:css, "a").attribute('href'))
  # variety name
  new_row.push(variety.find_element(:css, 'div a h3').text )
  # subvariety name
  new_row.push(variety.find_element(:css, 'div a span').text ) rescue new_row.push("")
  # variety description
  new_row.push(variety.find_element(:css, 'div p').text )

  csv_rows.push(new_row)
end

# export the scraped rows to CSV
CSV.open(csv_file, "wb", write_headers: true, headers: ['species', 'url', 'name', 'subname', 'description']) do |csv|

  csv_rows.each do |csvrow|

          csv << csvrow

  end

end



# close the browser and release its resources
driver.quit

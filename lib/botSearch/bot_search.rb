module Enumerable
  def pmap(&blok)
    pool = Concurrent::ThreadPoolExecutor.new(
        :min_threads => [2, Concurrent.processor_count].max,
        :max_threads => [2, Concurrent.processor_count].max + 10,
        :max_queue => [2, Concurrent.processor_count].max * 5,
        :fallback_policy => :caller_runs
    )
    futures = map { |e| Concurrent::Future.execute(:executor => pool) { blok.call(e) } }
    futures.map { |future| future.value }
  end
end

class BotSearch

  def run(cars_name_search)
    cars = []
    linki = FindLinks.new.linki
    print '[' + '_'*linki.size + ']'
    puts
    print '['
    linki.pmap do |link|
      cars << ExplorePage.new.search_car(cars_name_search, link)
      print '*'
    end
    puts ']'
    puts
    puts cars.any? ? cars : 'Brak wyników'
  end
end
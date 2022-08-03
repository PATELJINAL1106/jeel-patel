def get_command_line_argument
  # ARGV is an array that Ruby defines for us,
  # which contains all the arguments we passed to it
  # when invoking the script from the command line.
  #https://docs.ruby-lang.org/en/2.4.0/ARGF.html
  if ARGV.empty?
    puts "Usage: ruby lookup.rb <domain>"
    exit
  end
  ARGV.first
end

# `domain` contains the domain name we have to look up.
domain = get_command_line_argument

# File.readlines reads a file and returns an
# array of string, where each element is a line
# https://www.rubydoc.info/stdlib/core/IO:readlines
dns_raw = File.readlines("zone")

#p Resolv.getaddress "www.ruby-lang.org"
#p Resolv.getname "210.251.121.214"

#Resolv::DNS.open do |dns|
 # ress = dns.getresources "www.ruby-lang.org", Resolv::DNS::Resource::IN::A
  #p ress.map(&:address)
  #ress = dns.getresources "ruby-lang.org", Resolv::DNS::Resource::IN::MX
  #p ress.map { |r| [r.exchange.to_s, r.preference] }
#end

# ..
 #FILL YOUR CODE HERE
Resolv::DNS.new(:nameserver => ['210.251.121.21'],
               :search => ['ruby-lang.org'],
                :ndots => 1)
 

Resolv::DNS.new(:nameserver => ['172.217.163.46'],
                :search => ['google.com'],
                 :ndots => 2)
                 
  def initialize(config_info=nil)
      @mutex = Thread::Mutex.new
      @config = Config.new(config_info)
      @initialized = nil
    end


# To complete the assignment, implement `parse_dns` and `resolve`.
# Remember to implement them above this line since in Ruby
# you can invoke a function only after it is defined.
dns_records = parse_dns(dns_raw)
lookup_chain = [domain]
lookup_chain = resolve(dns_records, lookup_chain, domain)
puts lookup_chain.join(" => ")
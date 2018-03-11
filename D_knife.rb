#!/usr/bin/env ruby
# encoding: UTF-8
require 'net/http'
require 'open-uri'
require 'json'
require 'socket'
require 'optparse'

def banner()
red = "\033[01;31m"
green = "\033[01;32m"


puts "\n"
puts "     ____       __         _ ____      "
puts "    / __ \      / /______  (_) __/__    "
puts "   / / / /    / //_/ __ \/ / /_/ _ \   "
puts "  / /_/ /    / ,< / / / / / __/  __/  #THEDEADLYSWORD"
puts " /_____/____/_/|_/_/ /_/_/_/  \___/   #DAYAKNESE "
puts "      /_____/  "





puts "#{red}Fungsi Toolsnya Adalah Untuk Mengindentifikasi Ip Website yang di lindungi oleh CloudFlare "
puts "instagram.com/eeevvnx"
puts "github.com/S-Cyber/"
puts "Created By : The Deadly Sword"
puts "Create By : S-Cyber"

puts "\n"
end

options = {:bypass => nil, :massbypass => nil}
parser = OptionParser.new do|opts|

    opts.banner = "Contoh: ruby D_knife.rb -b <Target/Website Tujuan> Atau ruby D_knife.rb --byp <Target/Website>"
    opts.on('-b ','--byp ', 'Untuk Discover real IP Dari Target (bypass CloudFlare)', String)do |bypass|
    options[:bypass]=bypass;
    end

    opts.on('-o', '--out', 'Release selanjutnya.', String) do |massbypass|
        options[:massbypass]=massbypass

    end

    opts.on('--bantuan', '-B') do
        banner()
        puts opts
        puts "Contoh: ruby D_knife.rb -b Target/Tujuan.com atau ruby D_knife.rb --byp google.com"
        exit
    end
end

parser.parse!


banner()

if options[:bypass].nil?
    puts "Masukan URL  -b Atau --byp"
else
	option = options[:bypass]
	payload = URI ("http://www.crimeflare.org/cgi-bin/cfsearch.cgi")
	request = Net::HTTP.post_form(payload, 'cfS' => options[:bypass])

	response =  request.body
	nscheck = /No working nameservers are registered/.match(response)
	if( !nscheck.nil? )
		puts "[-] No valid address -Anda Yakin Bahwa Website ini di lindungi oleh CloudFlare ?\n"
		exit
	end
	regex = /(\d*\.\d*\.\d*\.\d*)/.match(response)
	if( regex.nil? || regex == "" )
		puts "[-] Alamat Yang Anda Masukan Tidak Valid Apakah Anda Yakin Domain Ini Di lindungi oleh CloudFlare?\n"
		puts "[-] Mungkin http://www.crimeflare.org sedang Down yang berperan sebagai payloadnya.\n"
		exit
	end
	ip_real = IPSocket.getaddress (options[:bypass])

	puts "[+] Menganalisi Website: #{option} "
	puts "[+] CloudFlare Ip #{ip_real} "
	puts "[+] Ip Asli  #{regex}"
	target = "http://ipinfo.io/#{regex}/json"
	url = URI(target).read
	json = JSON.parse(url)
	puts "[+] NamaHost: " + json['hostname']
	puts "[+] Kota: "  + json['city']
	puts "[+] Wilayah: " + json['country']
	puts "[+] Lokasi: " + json['loc']
	puts "[+] Organisasi: " + json['org']
puts " Terima Kasih Sudah Menggunakan Tools Ini Dengan Baik Jadilah Anak Indonesia Yang Berpikir Sebelum Mengambil Keputusan"
end

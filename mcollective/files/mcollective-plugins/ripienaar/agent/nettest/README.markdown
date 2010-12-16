# MCollective Ping Agent

This is a simple agent that will execute a ping or remote connection test on mcollective hosts

I often find myself logging onto boxed to ping different sites to diagnose local or remote network issues, this means I can now just issue a single command and get results from anywhere I'm running mcollective.

## Usage

`mc-rpc nettest ping fqdn="hostname"`
`mc-rpm nettest connect fqdn="hostname" port="nn"`

## Requirements

1. Ruby Gem net-ping (http://raa.ruby-lang.org/project/net-ping/)
2. mcollective running as root as uses ICMP pings, see gem for details

## Example

<code>
[root@host1 agent]$mc-rpc ping ping fqdn=google.com 
	Determining the amount of hosts matching filter for 2 seconds .... 9

	 * [ ============================================================> ] 9 / 9


	host1.example.com            
	   Time: Fri Oct 01 14:06:19 +0100 2010
	    RTT: 1.827
	   FQDN: google.com

	host2.example.com                      
	   Time: Fri Oct 01 15:06:19 +0200 2010
	    RTT: 6.679
	   FQDN: google.com

	host3.london.example.com               
	   Time: Fri Oct 01 14:06:19 +0100 2010
	    RTT: 9.417
	   FQDN: google.com

	host4.london.example.com                 
	   Time: Fri Oct 01 14:06:19 +0100 2010
	    RTT: 10.202
	   FQDN: google.com

	host5.london.example.com                 
	   Time: Fri Oct 01 14:06:19 +0100 2010
	    RTT: 10.199
	   FQDN: google.com

	host6.anotherdomain.co.uk             
	   Time: Fri Oct 01 14:06:48 +0100 2010
	    RTT: 4.084
	   FQDN: google.com

	host7                                    
	   Time: Fri Oct 01 14:06:19 +0100 2010
	    RTT: 15.072
	   FQDN: google.com

	host8.london.example.com                
	   Time: Fri Oct 01 14:06:19 +0100 2010
	    RTT: 10.251
	   FQDN: google.com

	host9.london.example.com                 
	   Time: Fri Oct 01 14:06:19 +0100 2010
	    RTT: 10.87
	   FQDN: google.com


	Finished processing 9 / 9 hosts in 179.58 ms
</code>

## TODO

1. HTTP status checks

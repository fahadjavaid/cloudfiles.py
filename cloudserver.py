import pyrax
pyrax.set_default_region("LON")
pyrax.set_credentials("davecottrell1", "799723e291376136b2b5a9cb7e0779ad")

""" List of servers in the account """

server_name = raw_input("Add server name: ")

"""Print list of servers already in the account"""

cs = pyrax.cloudservers
servers = cs.servers.list()
print servercore
print
print

"""List of Images available"""

imgs = cs.images.list()
for img in imgs:
   print img.name, "ID: ", img.id
   print
   print


""" List of flavors available"""

flavors = cs.flavors.list()
for flvs in flavors:
   print "Falvor Name: ", flvs.name
   print "Flavor ID: ", flvs.id
   print "Flavor Disk: ", flvs.disk
   print "Flavor RAM: " ,  flvs.ram
   print "Flavor VCPUs",flvs.vcpus
   print
   print


# Images created from your cloud servers:

#print cs.list_snapshots()

# Images provided from Rackspace:

#print cs.list_base_images()



# Now that we have "imgs" and "flavors" object we want.
# We only need the id attributes
# call the create method

flavor_160GB = [flavor for flavor in cs.flavors.list()
        if flavor.disk == 160]

print flavor_160GB

ubu_image = [img for img in cs.images.list()
        if "Windows Server 2008 R2 SP1" in img.name][0]
print ubu_image


#Creating a Server 

server = cs.servers.create(server_name, "d47aeca3-38d6-4dcb-bccf-534492986ae0" , "5")
print "ID:", server.id
print "Status:", server.status
print "Admin password:", server.adminPass
print "Networks:", server.networks

                               
new_server = pyrax.utils.wait_until(server, "status", ["ACTIVE", "ERROR"], attempts=0, interval =30, verbose=True)
if server.status == "ACTIVE":
    print "Congrats the Server Build has completed"
else:
    print "There is a problem with the Server Build"

#server = cs.servers.get(server.id)

##Refreshing the object


#server.delete[3]
#print cs.servers.list()
#cs = pyrax.cloudservers
#cs.servers.create_image("first_server", "api_challange_image")
#servers = cs.servers.list()
#print servers[4], strservers[4].id, servers[4].networks, servers[4].image





                      

import pyrax
pyrax.set_default_region("LON")
pyrax.set_setting("identity_type", "rackspace")
pyrax.set_credentials("username", "api_key")



"""cf stads for cloud files, pyrax cloud files"""
cf = pyrax.cloudfiles 

""" Create a Container """

print "This is the List of Existing Containers under your Account"
print cf.list_containers()
print cf.list_containers_info()


#name_of_container = raw_input("Please Enter the name for new container : ")
#cf.create_container(name_of_container)


""" List all containers """




 

""" Create Container """

#name_of_container = raw_input("Please Enter the name: ")

#cont = cf.create_container(name_of_container)

cont = cf.get_container("Fahad")
#print "Container: ", cont


"""Deleting the objects in the Container"""

#container_name = "Fahad"
#file_name = "IIS7NOTES"


#pyrax.cloudfiles.delete_container("Fahad")


    
cf.user_agent


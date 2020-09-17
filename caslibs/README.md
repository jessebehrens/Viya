# Caslibs
CASLIBs are methods for tying file locations, such as databases, filesystems, object storage, etc. to an in-memory space in CAS.  They provide a 
mechanism for loading data from disk into memory, often in a parallel manner.  Be aware, CASLIBS will only display what has been loaded into memory when you check the contents of a CASLIB.  There are methods for listing the files on a database/filesytem that we will demonstrate below.

The code here demonstrates how to connect CAS to different filesystems and databases. These are examples of different types of caslib connections
and use settings like numreadwrite, numreadnote, and authdomains for setting up CASLIBs for your specific use case.

 
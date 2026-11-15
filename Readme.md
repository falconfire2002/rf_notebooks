# RF_tools notebooks
this is a generic set of tools i use for learning and developing cpu based sdr systems if i alter fpga at anypoint
i will list it in the notebook with the relevant file in this repo

i prefer to avoid matlab as its expensive and while octave is great my work focuses on python and more
traditonal software languages so i use these tools


# the container
the container in this image takes ages to build and takes up a size able amout of harddrive
as it installs gnuradio from their scripts provide here
https://wiki.gnuradio.org/index.php?title=Building_GNU_Radio_from_Source_Code
it also form source installs
https://github.com/analogdevicesinc/libiio

i test this container build but not that its fully working so please provide notes 
container images are a mix of my work an ai i dont care to write them in full  

images are tested on podman so may need tweaks to work on docker(shouldnt as they standardise the same but some issue may appear another not is im using a linux os for this so windows users may find some changes are needed i dont know i would expect both mac and windows to be fine if the image builds)

# usage
i use jupyter alot for this as it best mimics a matlab live script for python

login is pluto

# disclaimer
im dyslexic so expect lots of spelling issues i will only fix them if i notice so feel free to put them as pulls if your using this but im unlikely to fix it 
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

build will likely take from 30 to 60 mins depending on pc
# usage
i use jupyter alot for this as it best mimics a matlab live script for python
http://localhost:8888
token is pluto (put this in the top box in the website)

at the top right of a python ipynb notebook their is a kernel with a circle wait till this circle is idle so that the kernel can run you code

#wifi plot notepad
their is an application showing teh wifi network fo 2.4ghz because pluto can only see one channel dont expect to get a wifi analyser out of the app also note that their is no data being obtained in this app. wap3 and 2 make it very difficult to view and are practical speaking impossible in cpu if you have an e31x device with rfnoc im certain the fpga could go further and get more out

# disclaimer
im dyslexic so expect lots of spelling issues i will only fix them if i notice so feel free to put them as pulls if your using this but im unlikely to fix it 
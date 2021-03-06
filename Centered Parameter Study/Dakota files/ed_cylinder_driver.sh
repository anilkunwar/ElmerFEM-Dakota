 # copyright (c) 2019 ASandip
 #This program is free software: you can redistribute it and/or 
 # modify it under the terms of the GNU General Public License as 
 # published by the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <https://www.gnu.org/licenses/>.


#!/bin/bash

# $1 and $2 are special variables in bash that contain the 1st and 2nd 
# command line arguments to the script, which are the names of the
# Dakota parameters and results files, respectively.

params=$1
results=$2

############################################################################### 
##
## Pre-processing Phase -- Generate/configure an input file for your simulation 
##  by substiting in parameter values from the Dakota paramters file.
##
###############################################################################

#Transfer new value for maximum velocity, at the cylinder inlet, from Dakota parameters file to Elmer simulation input file
#Both files are currently in the Dakota workspace/Dakota Project
dprepro $params case.template case.sif

#Transfer the Elmer simulation input file, case.sif, with new boundary conditions from Dakota workspace to Elmer workspace
cp /Dakota/Gui/Workspace/Dakota/Project/case.sif   /Elmer/Workspace/Project/Folder/case.sif

############################################################################### 
##
## Execution Phase -- Run your simulation
##
###############################################################################

#Open the Elmer project folder and run simulation in Elmer
cd /Elmer/Workspace/Project/Folder/
ElmerSolver case.sif


############################################################################### 
##
## Post-processing Phase -- Extract (or calculate) quantities of interest
##  from your simulation's output and write them to a properly-formatted
##  Dakota results file.
##
###############################################################################

#Extract the drag force at the final timestep from Elmer output and transfer it to Dakota results file, results.out
cp  /Elmer/Workspace/Project/Folder/dragforce.txt $results


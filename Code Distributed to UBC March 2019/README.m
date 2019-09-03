%{
README

To use provided data for different bats:
    
    From Dropbox, download all of the matlab code folder and the files pertaining to the
    bat you want to visualize. For example, if using the Carollia data set,
    download AreaFaces.m , Faces.m, and Directory.m and replace the files
    with the exact same names in the matlab code section with the same
    files from the Carollia file. Then download the data file and video
    file and edit the new Directory file so that the path of the files is
    correct.

USER REQUIREMENTS:

    The only requirement of the user for the animation is to have the same
    naming convention for the points on the bat. The naming convention is
    detailed in the following document:
    
    https://www.dropbox.com/s/jxc1bvt5tiyhm6y/naming%20convention.doc?dl=0

    If the user wants to superimpose the animation onto the original video,
    then the user needs to provide the translation vector, rotation
    matrix of the camera, and the intrinsic parameters matrix of the camera.
    Alternatively, the user can provide the DLT coefficients.

KEY FUNCTIONALITY:
    
    When the program is running and the animation is going, the user can
    control the animation with keys.

    To pause and unpause, press "p"
    To advance frame by frame, press the spacebar for each frame
    To fastforward five frames, press the right arrow key
    To rewind five frames, press the left arroy key
        For these last two, if the animation is paused it will remain
        paused, and if the animation is playing it will remain that way
    To go back to the original viewpoint, press "v"
    To activate the mouse crosshairs, press the tab key
        Once activated, when the user clicks on the plot, both the
        animation and the plots will go back to the frame where the plot
        was clicked
    To rotate and zoom in the animation, press the buttons at the top of
    the figure. Once the user has finished rotating or zooming, they should
    click the button again in order to be able to user key functions
    To exit animation, press the "Esc" and then click the x in the top
    right of the animation figure
    

FUNCTIONS: animaiton, TwoDAnimation, addVideo, organize, Points2Numbers, plots, area, extend,
xsubplots, Faces, AreaFaces, AoAttack, BatBasis, centerOfMass, derivative,
Inertia, and Radii.

animation: this is where all the logic of the bat animation is handled,
such as connecting points to visualize the basic bat structures and creates
the faces between the structures that represent the membrane. 

TwoDAnimation: this where all the logic of the 2-D bat animatino is
handled, such as connecting points to visualize the basic bat structures
and creates the faces between the structures that represent the membrane.
This function is used to superimpose the animation on the video.

addVideo: this is where the logic for adding the video to figure is
handled.

organize: this is where the array that represents the column headers
containing the coordinate references is organized to only include the point
names. This is important to be able to reference points based on their
position in this array.

Points2Numbers: this function attributes a number to each point so that
they can be easily referenced in arrays.

plots: this is where the plots are added a figure next the figure
containing the animation. The user chooses how many plots they want and
also fill in this function with their desired calculations. Points2Numbers
is called within this function so that the user knows how to reference each
point. xsubplots is also called in this function to create the subplots.

area: this function calculates the area of the triangle formed by three
points. This is used to calculate wing area

xsubplots: this helper function is used to create an amount of subplots
chosen by the user.

extend: this helper function is used to subtract the same displacement
vector from an array of column vectors.

Faces: this function returns an array which contains the configuration of
vertices which connect the faces that represent the membrane. The user is
responsible filling in this matrix. Instructions will be provided.

AreaFaces: this function returns two array which contain the configuration
of the different faces that represent the membrane of which wing. This is
then used to calculate the wing area

AoAttack: this is a helper function which calculates the angle of attack of
the chosen wing

BatBasis: this function returns x,y, and z data in the bat coordinate
system with inputs being another set of x,y and z data and the new origin.
The bat x-axis is along the back of the bat, and the y-axis is across the
back in the direction of the wingtip. The z-axis is perpindicular to the
back of the bat. 

centerOfMass: this calculates the center of mass of the bat in the
coordinates inputted at the desired timestep. It returns the x,y, and z
coordinates of the center of mass.

derivative: It returns the estimated derivative of the input data. The
function fits a polynomial of a chosen degree across a chosen number of
points for the entire data set and then differentiates the polynomial to
estimate the derivative

Inertia: returns the inertia matrix of the bat using the same x,y, and z
axes as defined in BatBasis

Radii: this function returns the coordinates of where mass is distributed
throughout the bat. It returns two sets of coordinates, one for the left
wing and one for the right wing. The mass of the body is included in the
array of the right wing. To improve the accuracy of the inertia
calculations the mass is distributed even more so along the segments so
that the segments resemble rods more than point masses. 



INSTRUCTIONS: 

To fill in the Faces matrix:

    The user should make faces between the vertices that represents the
    membrane. The faces can have any amount of vertices but a normal amount
    is three or four vertices per face. Each row of the matrix contains the
    vertices of the face separated by commas. If the number of vertices per
    face is not uniform, then the extra spaces in the rows with fewer
    spaces need to be filled in by NaN's. An example with three vertices
    per face is provided as the default.

To plot desired calculations:

    Data the user can use in their calculations:
        
        All in global coordinate system:
            x,y,and z positions at every point
                    xData(t,PointName), where t is the timestep
            x,y,and z velocities at every point
                    Ux(t,PointName)
            x,y,and z accelerations at every point
                    Ax(t,PointName)

        All in the bat coordinate system:
            x,y,and z positions at every point
                    xBasisData(t,PointName), where t is the timestep
            x,y,and z velocities at every point
                    UxBasis(t,PointName)
            x,y,and z accelerations at every point
                    AxBasis(t,PointName)
            x,y,and z angular velocities at every point
                    Omegax(t,PointName)
            x,y,and z angular accelerations at every point
                    Alphax(t,PointName)
            azimuthal and polar angles at every point
                    thetaData(t,PointName) - azimuthal
                    phiData(t,PointName) - polar
            Inertia matrix
                    3x3 matrix:
                        I = Inertia(t)
                        I(i,j) for desired inertia
            x,y,and z center of mass positions
                    xcData(t)
            x,y,and z center of mass velocities
                    Uxc(t)
            x,y,and z center of mass accelerations
                    Axc(t)
            x,y,and z angular velocities of center of mass
                    Omegaxc(t)
            x,y,and z angular accelerations of center of mass
                    Alphaxc(t)

    The user should use the named references to each point in the
    fucntion. The provided template has three plots

    If the user wants to make three calculations per side, then they can 
    change the right side of the equations. To reference the x-coordinate
    of a point, write xData(i,"name of point"). Change x to y and z for the
    y and z coordinates. 

    If the user has less than three calculations per side, delete the
    unused calculations and also delete the code that plots the
    calculations, which will be pointed out. 

    If the user wants to make more than three calculations, then add the
    calculations for each side. For the nth calculation, write 
    dL(i,n) = "calculation" for the calculation on the left side and
    dR(i,n) = "calculation" for the calculation on the right side. To plot
    the added calculations copy the previous sections so that for the nth
    plot you have: 
    
    if Right == 0
    plot(haxes(n),1:1:t,dL(:,n),  'b');
    end
    set(haxes(n),'Nextplot','add');
    ylabel(haxes(n),'plot n');
    if Left == 0
    plot(haxes(n),1:1:t, dR(:,n),  'r');
    end
    
    To change the ylabel of each plot, edit the code within apostrophes in
    the lines that start with "ylabel".

    Possible problems if done incorrectly:
    
    If there are more plots than calculations plotted then there will be
    empty plots.
    
    If the user attempts to plot more calculations that there are plots
    then the program will not run.


To add a new point:
    
    1. Decide on a name for the point to reference it throughout
    2. In the organize function add the following lines within the switch
       statement:

        case  'name of point_Z' 
          Points2{1,i/3} =  'Le01R' ;
    3. In the Points2Numbers function add the name of the point as an
       output of the function. Also add the following lines within the switch
       statement:
        case  'name of point' 
                name of point = i;
    4. In the plots function add the new point as an output when
       Points2Numbers is called at the beginning of the file
    5. In the animation function add the new point as an output when
       Points2Numbers is called at the beginning of the file
    6. In the Faces function add the new point as an output when
       Points2Numbers is called at the beginning of the file
    7. If the user wants the new point to be a vertex of a face of the
       membrane, then add to Faces matrix as necessary
    8. Within the animation function, to add new point to a structure,
       the user has to note where the point lies in the structure in
       relation to the other points in the structure. When referencing the
       different end of the structure, the front end refers to the first
       point in each row of the basic configuration of the structure, and
       the back end refers to the last point in each row of the basic
       configuration of the structure.
            i. To replace an existing point in the structure go to the
               where that point is add, whether in the basic configuration
               or after and replace the name of the old point with the new
               point
            ii. To add the point to the front end of the configuration,
               add the point to the beginning of each row by writing 
               Bat(row, new point) where the basic configureation is
               defined. Also increase the value of "size" by 1
            iii. To add the point to the back end of the configuration,
               add the point to the end of each row by writing 
               Bat(row, new point) where the basic configureation is
               defined. Also increase the value of "size" by 1
            iv. To add the point to the middle of the structure, add the
               point to the corresponding position in the basic
               configuration. Increase the value of "size" by 1. If the
               structure contains other points apart from the basic
               configuration that the user is tracking, then the user may
               have to edit the code that adds the other points. If the
               point that the user is adding is closer to front end of the
               structure than any other point being added to the
               structure, then the following changes are made after the
               basic configuration:
               
               strct(:,1:n) becomes strct(:,1:n+1)
               strct(:,m:size) becomes strct(:,m+1:size)

    9. Within the animation function to add a new structure containing the
       new point write the following lines:
        
       strct = [Bat(1,point1),Bat(1,point2),Bat(1,newPoint), ... Bat(1,pointN); ...
            Bat(2,point1),Bat(2,point2),Bat(2,newPoint), ... Bat(2,pointN); ...
            Bat(3,point1),Bat(3,point2),Bat(3,newPoint), ... Bat(3,pointN)];
       size = N;
       D = extend(dstr, size);

       plot3(axes,strct(1,:)-D(1,:),strct(2,:)-D(2,:),strct(3,:)-D(3,:),'r','LineWidth',5)
       
       The user can change the color of the structure by replacing 'r' with
       what they want. Similarly they can change the width of the line by
       changing "5". 
        
       The order of the points within the strct array should be the same as
       in the actual structure.
               
        
To run the program:
    
    Go to the LopezU_BatAnimation file and to the initialzing variables
    section at the very top and follow the instructions there. Then run the
    program.

KNOWN BUGS:
    
    Animation gets messed up if you click on the plots figure when the
    mouse crosshairs are not activated.


Email jlopezur@brown.edu if you find other bugs or if the program can't
run for an unknown reason.
    

%}
# AFEIO
Alignment, fusion, and extraction all-in-one software (AFEIO) for processing big light sheet image data.

Main 
	Installation
Open the file Main.m in the AFEIO folder with MatLab and run it. In order to open the images usually acquired as bio formats, we used the bioformats package[1] (27) downloaded from https://www.openmicroscopy.org/bio-formats/downloads/, and copied the bfopen file into the AFEIO folder.

Main GUI (Graphical User Interface)
The main pipeline comprises three main parts: Fuse data, Projection, and Alignment. The three parts can run independently. Click a button to jump into the corresponding part. 

Fuse data
	Description and data arrangement
    This step fuses the stacks acquired from two opposing views, and the raw data should be arranged as follows:
Name: “time point _G group index”, for example, “233_G1” means time point 233 and group one. 
Image stack sequence: In one group, the sequence should be, channel1left-channel2left (if had)-channel1right-channel2right (if had). Channel1 is the channel used for main analysis and channel2 is the co-localization channel.
Image stack group: We assumed that during the image acquisition, there was only one camera and it was fixed, and the sample was rotated 180° to acquire group2. In other words, group 2 is rotated by 180° in the processing pipeline. 
	Data fusion GUI
    The main GUI of the data fusion part is shown in Fig. 2.
	 Select input files
    Click the “Select input files” button and a window appears. The user may select the folder where the files were saved, and then select one of the files to be processed. After selection, the path is shown in the box before the button, and the selected time point is shown in the “Processing time point range” box.
	 Select output folder
    Click the “Select output folder” button to select where the processed data are to be saved, and this is shown in the box before the button. Please make sure the disk has enough space.
	 Crosstalk intensity
    If there is crosstalk from channel 1 to channel 2, the user may estimate the crosstalk intensity as in Fig. 3. Select two pairs of regions as follows: (1) a pair of background regions (Fig. 3A, B) and (2) a pair of regions with only the signal from a channel (Fig. 3C, D), then calculate the respective averages of the pairs as b1, b2 and s1, s2, for channels 1 and 2 Then the crosstalk intensity c is given by: 
    c=(s1-b1)/(s2-b2)
If c = 0, there is no need for crosstalk correction.
	 Maximal cell size
    When estimating the maximal cell size, note that the unit is the pixel. This parameter is used to estimate the image background.
	 Channel 2 added at
    A second marker may be used for co-localization during imaging, and if this marker is not expressed from the beginning, the second channel may be added at a later time point; in other words, channel 2 can be added at this time point. For example, “233” means that before time point 233, there is only one channel in each stack, and after (and including) time point 233, there are two channels.
	 Group 2 started and Group 1 started
    To ensure that the whole sample is covered, there may be extra blank planes at the end of the stacks. This parameter determines the useful range among all planes. For example, 100 means the planes whose indexes are before (and excluding) 100 will be ignored during the processing. If the blank planes have been removed, “1” means that all planes are useful and none are to be ignored.
	 Processing time point range
    Determine the processing time point range. In the previous “Select input files” step, a single time point was selected. If there are multiple time points, they should be connected by commas or hyphens. A comma means “and” and a hyphen means “from to”. For example, “1,4,7-10” comprises 6 time points (1, 4, 7, 8, 9, and 10).
	 Now processing time point
    This box is a reminder showing which time point is being processed.
	 Start, Interrupt, and Back 
    Click “Start” when all setups have been completed, and the processing will start.
During processing, if the “Interrupt!” button is pressed, the algorithm will stop after processing the current time point.
Click “Back” if the data fusion step has finished; the user can quit and jump to home.
	Test case
    A test case named testcase is attached.

Projection
	Description
    This process is to preview or to save the projection of stacks for both the main and side views.
Projection GUI
    The main GUI of the projection part is shown in Fig. 4.
	 Select input files
    Click the “Select input files” button and a window appears. The user may select the folder where the processed data was saved, then select one of the files to be projected. After selection, the path is shown in the box before the button, and the selected time point is shown in the “Processing time point range” box.
	 Select output folder 
    Click the “Select output folder” button to select where the processed data are to be saved; this is shown in the box before the button. Please make sure the disk has enough space.
	 Slice spacing
    The ratio of the distance between two slices and the size of a single pixel. For example, if the slice step is 3 μm, and a single pixel represents 0.5 μm, the slice spacing is 3/0.5 = 6 pixels.
	 Show projection
    Whether to show the results on the screen.
	 Processing time point range
    Determine the processing time point range. In the previous “Select input files” step, a single time point was selected. If there are multiple time points, they should be connected by commas or hyphens. A comma means “and” and a hyphen means “from to”. For example, “1,4,7-10” comprises 6 time points (1, 4, 7, 8, 9, and 10).
	 Start, Interrupt, and Back 
    Click “Start” when all setups have been completed, the processing starts.
During processing, if the “Interrupt!” button is pressed, the algorithm stops after processing the current time point.
Click “Back” if the data fusion step has finished; the user can quit and jump to home.
Alignment
	Description
    This process is to correct the shift between different time points based on the projection acquired from the projection step.
	Alignment GUI
	 Aligning time points range
    Time points where there are shifts need to be aligned. For example, if the sample moved during the acquisition between time points 155 and 154, and 342 and 341, the input should be 155,342. Also, these time points should be connected by commas and hyphens; a comma means “and” and a hyphen means “from to”.
	 Select projection saving folder
    Click the “Select projection saving folder” button and a window appears. The user may select the folder where the projections are saved to select a file.
	 Calculate, Crop range, and Crop test
    When the above setups have been completed, click the “Calculate” button to align the projections. After this step, a folder new will appear in the folder where the projection was saved, and two image stacks Front.tif and Side.tif are in the folder for preview. Also, the Crop range suggestion appears in the box below, so the user can also manually change the crop range. After setting the crop range, click “Crop test” to generate the file Crop.tif in the new folder to determine whether the parameters are suitable.
	 Select data saving folder and Start aligning
    Select where the fused data are to be saved. Make sure all the parameters have been set properly because this step overwrites the old files. Click “Start” when all setups have been completed, and the processing will start.
	 Back
    Click “Back” if the data fusion step has finished; the user can quit and jump to home.

Citation
[1] Linkert M, Rueden C T, Allan C, et al., Metadata matters: access to image data in the real world [J]. The Journal of Cell Biology, 2010, 189(5):777-782.

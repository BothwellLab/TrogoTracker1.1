TrogoTracker v1.1 is an incremental update over the original TrogoTracker FIJI macro. The update introduces semi-autonomous imaging that still requires human validation.
Trogotracker v1.1 requires MatLab, please use the original TrogoTracker (bit.ly/TrogoTracker) for analysis using FIJI only. 
1. Set up StarDist2D and TrogoTracker on FIJI is Just ImageJ (FIJI): Select Help -> Update, and then click on "Manage Update Sites".
3. Check "CBSDeep" and "StarDist". Troubleshooting: https://github.com/stardist/stardist-imagej
4. Copy the contents of the TrogoTracker Script (bit.ly/TrogoTracker) into FIJI Startup Macros
5. Create a folder containing the individual channel images to be analyzed. Ensure that you have a nuclear marker, a tumor marker, and a "trogocytosis" marker of interest.
6. Insert the "find_files.m" file into the folder containing the individual channel images.
7. Generate a Microsoft Excel File where your data is to be output
8. In "trogo_tracker1-1.m" navigate to output_files = "" and insert the file path of the Excel file created in the previous step.
9. Change any MatLab Paths if on a different version other than R2023a.
10. Install the MatLab Package MIJ: https://www.mathworks.com/matlabcentral/fileexchange/47545-mij-running-imagej-and-fiji-within-matlab
11. Run "trogo_tracker1-1.m" within MatLab. 

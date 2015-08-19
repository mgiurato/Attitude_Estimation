//
// MATLAB Compiler: 4.8 (R2008a)
// Date: Sat Jan 08 15:26:47 2011
// Arguments: "-B" "macro_default" "-W"
// "dotnet:CalibrationAlgorithmsMATLAB,CalibrationAlgorithmsMATLABclass,0.0,private" "-d"
// "C:\Users\Seb Madgwick\Desktop\Automated Calibration Feasbility Study\Source Code and
// Resources\Calibration Algorithms MATLAB\CalibrationAlgorithmsMATLAB\src" "-T"
// "link:lib" "-v" "-C" "class{CalibrationAlgorithmsMATLABclass:C:\Users\Seb
// Madgwick\Desktop\Automated Calibration Feasbility Study\Source Code and
// Resources\Calibration Algorithms MATLAB\calibrateAccelMag.m,C:\Users\Seb
// Madgwick\Desktop\Automated Calibration Feasbility Study\Source Code and
// Resources\Calibration Algorithms MATLAB\calibrateGyro.m,C:\Users\Seb
// Madgwick\Desktop\Automated Calibration Feasbility Study\Source Code and
// Resources\Calibration Algorithms MATLAB\objFunAccelMag.m,C:\Users\Seb
// Madgwick\Desktop\Automated Calibration Feasbility Study\Source Code and
// Resources\Calibration Algorithms MATLAB\objFunGyro.m}" 
//


using System;

namespace CalibrationAlgorithmsMATLAB
{
  /// <summary>
  /// The MCR Component State
  /// </summary>
  public class MCRComponentState
    {
      /// <summary>
      /// The .NET Builder component name
      /// </summary>
      public static string MCC_CalibrationAlgorithmsMATLAB_name_data= "CalibrationAlgorithmsMATLAB";

      /// <summary>
      /// The component root data
      /// </summary>
      public static string MCC_CalibrationAlgorithmsMATLAB_root_data= "";

      /// <summary>
      /// The public encryption key for the .NET Builder component
      /// </summary>
      public static byte[] MCC_CalibrationAlgorithmsMATLAB_public_data=
                              {(byte)'3', (byte)'0', (byte)'8', (byte)'1',
                               (byte)'9', (byte)'D', (byte)'3', (byte)'0',
                               (byte)'0', (byte)'D', (byte)'0', (byte)'6',
                               (byte)'0', (byte)'9', (byte)'2', (byte)'A',
                               (byte)'8', (byte)'6', (byte)'4', (byte)'8',
                               (byte)'8', (byte)'6', (byte)'F', (byte)'7',
                               (byte)'0', (byte)'D', (byte)'0', (byte)'1',
                               (byte)'0', (byte)'1', (byte)'0', (byte)'1',
                               (byte)'0', (byte)'5', (byte)'0', (byte)'0',
                               (byte)'0', (byte)'3', (byte)'8', (byte)'1',
                               (byte)'8', (byte)'B', (byte)'0', (byte)'0',
                               (byte)'3', (byte)'0', (byte)'8', (byte)'1',
                               (byte)'8', (byte)'7', (byte)'0', (byte)'2',
                               (byte)'8', (byte)'1', (byte)'8', (byte)'1',
                               (byte)'0', (byte)'0', (byte)'C', (byte)'4',
                               (byte)'9', (byte)'C', (byte)'A', (byte)'C',
                               (byte)'3', (byte)'4', (byte)'E', (byte)'D',
                               (byte)'1', (byte)'3', (byte)'A', (byte)'5',
                               (byte)'2', (byte)'0', (byte)'6', (byte)'5',
                               (byte)'8', (byte)'F', (byte)'6', (byte)'F',
                               (byte)'8', (byte)'E', (byte)'0', (byte)'1',
                               (byte)'3', (byte)'8', (byte)'C', (byte)'4',
                               (byte)'3', (byte)'1', (byte)'5', (byte)'B',
                               (byte)'4', (byte)'3', (byte)'1', (byte)'5',
                               (byte)'2', (byte)'7', (byte)'7', (byte)'E',
                               (byte)'D', (byte)'3', (byte)'F', (byte)'7',
                               (byte)'D', (byte)'A', (byte)'E', (byte)'5',
                               (byte)'3', (byte)'0', (byte)'9', (byte)'9',
                               (byte)'D', (byte)'B', (byte)'0', (byte)'8',
                               (byte)'E', (byte)'E', (byte)'5', (byte)'8',
                               (byte)'9', (byte)'F', (byte)'8', (byte)'0',
                               (byte)'4', (byte)'D', (byte)'4', (byte)'B',
                               (byte)'9', (byte)'8', (byte)'1', (byte)'3',
                               (byte)'2', (byte)'6', (byte)'A', (byte)'5',
                               (byte)'2', (byte)'C', (byte)'C', (byte)'E',
                               (byte)'4', (byte)'3', (byte)'8', (byte)'2',
                               (byte)'E', (byte)'9', (byte)'F', (byte)'2',
                               (byte)'B', (byte)'4', (byte)'D', (byte)'0',
                               (byte)'8', (byte)'5', (byte)'E', (byte)'B',
                               (byte)'9', (byte)'5', (byte)'0', (byte)'C',
                               (byte)'7', (byte)'A', (byte)'B', (byte)'1',
                               (byte)'2', (byte)'E', (byte)'D', (byte)'E',
                               (byte)'2', (byte)'D', (byte)'4', (byte)'1',
                               (byte)'2', (byte)'9', (byte)'7', (byte)'8',
                               (byte)'2', (byte)'0', (byte)'E', (byte)'6',
                               (byte)'3', (byte)'7', (byte)'7', (byte)'A',
                               (byte)'5', (byte)'F', (byte)'E', (byte)'B',
                               (byte)'5', (byte)'6', (byte)'8', (byte)'9',
                               (byte)'D', (byte)'4', (byte)'E', (byte)'6',
                               (byte)'0', (byte)'3', (byte)'2', (byte)'F',
                               (byte)'6', (byte)'0', (byte)'C', (byte)'4',
                               (byte)'3', (byte)'0', (byte)'7', (byte)'4',
                               (byte)'A', (byte)'0', (byte)'4', (byte)'C',
                               (byte)'2', (byte)'6', (byte)'A', (byte)'B',
                               (byte)'7', (byte)'2', (byte)'F', (byte)'5',
                               (byte)'4', (byte)'B', (byte)'5', (byte)'1',
                               (byte)'B', (byte)'B', (byte)'4', (byte)'6',
                               (byte)'0', (byte)'5', (byte)'7', (byte)'8',
                               (byte)'7', (byte)'8', (byte)'5', (byte)'B',
                               (byte)'1', (byte)'9', (byte)'9', (byte)'0',
                               (byte)'1', (byte)'4', (byte)'3', (byte)'1',
                               (byte)'4', (byte)'A', (byte)'6', (byte)'5',
                               (byte)'F', (byte)'0', (byte)'9', (byte)'0',
                               (byte)'B', (byte)'6', (byte)'1', (byte)'F',
                               (byte)'C', (byte)'2', (byte)'0', (byte)'1',
                               (byte)'6', (byte)'9', (byte)'4', (byte)'5',
                               (byte)'3', (byte)'B', (byte)'5', (byte)'8',
                               (byte)'F', (byte)'C', (byte)'8', (byte)'B',
                               (byte)'A', (byte)'4', (byte)'3', (byte)'E',
                               (byte)'6', (byte)'7', (byte)'7', (byte)'6',
                               (byte)'E', (byte)'B', (byte)'7', (byte)'E',
                               (byte)'C', (byte)'D', (byte)'3', (byte)'1',
                               (byte)'7', (byte)'8', (byte)'B', (byte)'5',
                               (byte)'6', (byte)'A', (byte)'B', (byte)'0',
                               (byte)'F', (byte)'A', (byte)'0', (byte)'6',
                               (byte)'D', (byte)'D', (byte)'6', (byte)'4',
                               (byte)'9', (byte)'6', (byte)'7', (byte)'C',
                               (byte)'B', (byte)'1', (byte)'4', (byte)'9',
                               (byte)'E', (byte)'5', (byte)'0', (byte)'2',
                               (byte)'0', (byte)'1', (byte)'1', (byte)'1'};

      /// <summary>
      /// The session encryption key for the .NET Builder component
      /// </summary>
      public static byte[] MCC_CalibrationAlgorithmsMATLAB_session_data=
                              {(byte)'0', (byte)'D', (byte)'C', (byte)'B',
                               (byte)'D', (byte)'F', (byte)'0', (byte)'C',
                               (byte)'5', (byte)'B', (byte)'6', (byte)'D',
                               (byte)'5', (byte)'1', (byte)'B', (byte)'1',
                               (byte)'4', (byte)'6', (byte)'0', (byte)'B',
                               (byte)'F', (byte)'4', (byte)'F', (byte)'B',
                               (byte)'D', (byte)'0', (byte)'F', (byte)'4',
                               (byte)'7', (byte)'D', (byte)'1', (byte)'1',
                               (byte)'6', (byte)'8', (byte)'6', (byte)'3',
                               (byte)'2', (byte)'6', (byte)'2', (byte)'F',
                               (byte)'9', (byte)'2', (byte)'1', (byte)'8',
                               (byte)'9', (byte)'7', (byte)'0', (byte)'2',
                               (byte)'F', (byte)'A', (byte)'7', (byte)'F',
                               (byte)'5', (byte)'D', (byte)'9', (byte)'1',
                               (byte)'C', (byte)'2', (byte)'5', (byte)'E',
                               (byte)'A', (byte)'1', (byte)'E', (byte)'B',
                               (byte)'0', (byte)'B', (byte)'1', (byte)'E',
                               (byte)'B', (byte)'0', (byte)'8', (byte)'E',
                               (byte)'3', (byte)'2', (byte)'A', (byte)'1',
                               (byte)'A', (byte)'1', (byte)'5', (byte)'4',
                               (byte)'2', (byte)'F', (byte)'D', (byte)'D',
                               (byte)'B', (byte)'6', (byte)'D', (byte)'C',
                               (byte)'4', (byte)'C', (byte)'C', (byte)'1',
                               (byte)'B', (byte)'0', (byte)'7', (byte)'B',
                               (byte)'4', (byte)'D', (byte)'4', (byte)'C',
                               (byte)'2', (byte)'5', (byte)'8', (byte)'E',
                               (byte)'D', (byte)'1', (byte)'C', (byte)'3',
                               (byte)'F', (byte)'4', (byte)'4', (byte)'2',
                               (byte)'5', (byte)'B', (byte)'3', (byte)'5',
                               (byte)'9', (byte)'F', (byte)'B', (byte)'2',
                               (byte)'1', (byte)'9', (byte)'2', (byte)'A',
                               (byte)'3', (byte)'4', (byte)'0', (byte)'B',
                               (byte)'A', (byte)'5', (byte)'7', (byte)'4',
                               (byte)'E', (byte)'2', (byte)'F', (byte)'0',
                               (byte)'4', (byte)'8', (byte)'3', (byte)'4',
                               (byte)'C', (byte)'B', (byte)'F', (byte)'9',
                               (byte)'6', (byte)'5', (byte)'5', (byte)'2',
                               (byte)'1', (byte)'1', (byte)'7', (byte)'0',
                               (byte)'0', (byte)'7', (byte)'4', (byte)'F',
                               (byte)'B', (byte)'9', (byte)'6', (byte)'F',
                               (byte)'C', (byte)'6', (byte)'7', (byte)'E',
                               (byte)'A', (byte)'A', (byte)'0', (byte)'5',
                               (byte)'E', (byte)'1', (byte)'8', (byte)'0',
                               (byte)'8', (byte)'E', (byte)'A', (byte)'2',
                               (byte)'9', (byte)'9', (byte)'0', (byte)'3',
                               (byte)'4', (byte)'9', (byte)'6', (byte)'2',
                               (byte)'6', (byte)'2', (byte)'F', (byte)'2',
                               (byte)'7', (byte)'D', (byte)'6', (byte)'0',
                               (byte)'E', (byte)'F', (byte)'B', (byte)'1',
                               (byte)'C', (byte)'E', (byte)'0', (byte)'B',
                               (byte)'D', (byte)'3', (byte)'3', (byte)'8',
                               (byte)'C', (byte)'1', (byte)'A', (byte)'F',
                               (byte)'F', (byte)'E', (byte)'9', (byte)'D',
                               (byte)'3', (byte)'C', (byte)'1', (byte)'1',
                               (byte)'D', (byte)'7', (byte)'5', (byte)'3',
                               (byte)'3', (byte)'8', (byte)'3', (byte)'4',
                               (byte)'E', (byte)'9', (byte)'B', (byte)'B',
                               (byte)'6', (byte)'1', (byte)'D', (byte)'B',
                               (byte)'E', (byte)'B', (byte)'D', (byte)'F',
                               (byte)'5', (byte)'3', (byte)'A', (byte)'B',
                               (byte)'6', (byte)'5', (byte)'D', (byte)'B',
                               (byte)'5', (byte)'5', (byte)'9', (byte)'E',
                               (byte)'9', (byte)'D', (byte)'D', (byte)'2',
                               (byte)'4', (byte)'D', (byte)'A', (byte)'2'};

      /// <summary>
      /// The MATLAB path for the .NET Builder component
      /// </summary>
      public static string[] MCC_CalibrationAlgorithmsMATLAB_matlabpath_data= {"CalibrationA/",
                                                                               "toolbox/compiler/deploy/",
                                                                               "$TOOLBOXMATLABDIR/general/",
                                                                               "$TOOLBOXMATLABDIR/ops/",
                                                                               "$TOOLBOXMATLABDIR/lang/",
                                                                               "$TOOLBOXMATLABDIR/elmat/",
                                                                               "$TOOLBOXMATLABDIR/elfun/",
                                                                               "$TOOLBOXMATLABDIR/specfun/",
                                                                               "$TOOLBOXMATLABDIR/matfun/",
                                                                               "$TOOLBOXMATLABDIR/datafun/",
                                                                               "$TOOLBOXMATLABDIR/polyfun/",
                                                                               "$TOOLBOXMATLABDIR/funfun/",
                                                                               "$TOOLBOXMATLABDIR/sparfun/",
                                                                               "$TOOLBOXMATLABDIR/scribe/",
                                                                               "$TOOLBOXMATLABDIR/graph2d/",
                                                                               "$TOOLBOXMATLABDIR/graph3d/",
                                                                               "$TOOLBOXMATLABDIR/specgraph/",
                                                                               "$TOOLBOXMATLABDIR/graphics/",
                                                                               "$TOOLBOXMATLABDIR/uitools/",
                                                                               "$TOOLBOXMATLABDIR/strfun/",
                                                                               "$TOOLBOXMATLABDIR/imagesci/",
                                                                               "$TOOLBOXMATLABDIR/iofun/",
                                                                               "$TOOLBOXMATLABDIR/audiovideo/",
                                                                               "$TOOLBOXMATLABDIR/timefun/",
                                                                               "$TOOLBOXMATLABDIR/datatypes/",
                                                                               "$TOOLBOXMATLABDIR/verctrl/",
                                                                               "$TOOLBOXMATLABDIR/codetools/",
                                                                               "$TOOLBOXMATLABDIR/helptools/",
                                                                               "$TOOLBOXMATLABDIR/winfun/",
                                                                               "$TOOLBOXMATLABDIR/demos/",
                                                                               "$TOOLBOXMATLABDIR/timeseries/",
                                                                               "$TOOLBOXMATLABDIR/hds/",
                                                                               "$TOOLBOXMATLABDIR/guide/",
                                                                               "$TOOLBOXMATLABDIR/plottools/",
                                                                               "toolbox/local/",
                                                                               "toolbox/shared/dastudio/",
                                                                               "$TOOLBOXMATLABDIR/datamanager/",
                                                                               "toolbox/compiler/",
                                                                               "toolbox/shared/optimlib/",
                                                                               "toolbox/optim/optim/"};
      /// <summary>
      /// The MATLAB path count
      /// </summary>
      public static int MCC_CalibrationAlgorithmsMATLAB_matlabpath_data_count= 40;

      /// <summary>
      /// The class path for the .NET Builder component
      /// </summary>
      public static string[] MCC_CalibrationAlgorithmsMATLAB_classpath_data= {"\0"};

      /// <summary>
      /// The class path count
      /// </summary>
      public static int MCC_CalibrationAlgorithmsMATLAB_classpath_data_count= 0;

      /// <summary>
      /// The lib path for the .NET Builder component
      /// </summary>
      public static string[] MCC_CalibrationAlgorithmsMATLAB_libpath_data= {"\0"};

      /// <summary>
      /// The lib path count
      /// </summary>
      public static int MCC_CalibrationAlgorithmsMATLAB_libpath_data_count= 0;

      /// <summary>
      /// The MCR application options
      /// </summary>
      public static string[] MCC_CalibrationAlgorithmsMATLAB_mcr_application_options= {"\0"};

      /// <summary>
      /// The MCR application options count
      /// </summary>
      public static int MCC_CalibrationAlgorithmsMATLAB_mcr_application_option_count= 0;

      /// <summary>
      /// The MCR runtime options
      /// </summary>
      public static string[] MCC_CalibrationAlgorithmsMATLAB_mcr_runtime_options= {"\0"};

      /// <summary>
      /// The MCR runtime options count
      /// </summary>
      public static int MCC_CalibrationAlgorithmsMATLAB_mcr_runtime_option_count= 0;

      /// <summary>
      /// The component preferences directory
      /// </summary>
      public static string MCC_CalibrationAlgorithmsMATLAB_mcr_pref_dir= "CalibrationA_AE8F2E5AFABF3649DA39DA92CE96397C";

      /// <summary>
      /// Runtime warning states
      /// </summary>
      public static string[] MCC_CalibrationAlgorithmsMATLAB_set_warning_state= {"off:MATLAB:dispatcher:nameConflict"};
      /// <summary>
      /// Runtime warning state count
      /// </summary>
      public static int MCC_CalibrationAlgorithmsMATLAB_set_warning_state_count= 0;
    }
}

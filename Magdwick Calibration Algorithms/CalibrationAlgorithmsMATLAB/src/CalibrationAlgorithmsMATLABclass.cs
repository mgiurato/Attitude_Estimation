/*
* MATLAB Compiler: 4.8 (R2008a)
* Date: Sat Jan 08 15:26:47 2011
* Arguments: "-B" "macro_default" "-W"
* "dotnet:CalibrationAlgorithmsMATLAB,CalibrationAlgorithmsMATLABclass,0.0,private" "-d"
* "C:\Users\Seb Madgwick\Desktop\Automated Calibration Feasbility Study\Source Code and
* Resources\Calibration Algorithms MATLAB\CalibrationAlgorithmsMATLAB\src" "-T"
* "link:lib" "-v" "-C" "class{CalibrationAlgorithmsMATLABclass:C:\Users\Seb
* Madgwick\Desktop\Automated Calibration Feasbility Study\Source Code and
* Resources\Calibration Algorithms MATLAB\calibrateAccelMag.m,C:\Users\Seb
* Madgwick\Desktop\Automated Calibration Feasbility Study\Source Code and
* Resources\Calibration Algorithms MATLAB\calibrateGyro.m,C:\Users\Seb
* Madgwick\Desktop\Automated Calibration Feasbility Study\Source Code and
* Resources\Calibration Algorithms MATLAB\objFunAccelMag.m,C:\Users\Seb
* Madgwick\Desktop\Automated Calibration Feasbility Study\Source Code and
* Resources\Calibration Algorithms MATLAB\objFunGyro.m}" 
*/

using System;
using System.Reflection;

using MathWorks.MATLAB.NET.Arrays;
using MathWorks.MATLAB.NET.Utility;


[assembly: System.Reflection.AssemblyVersion("0.0.*")]
#if SHARED
[assembly: System.Reflection.AssemblyKeyFile(@"")]
#endif

namespace CalibrationAlgorithmsMATLAB
{
  /// <summary>
  /// The CalibrationAlgorithmsMATLABclass class provides a CLS compliant interface to
  /// the M-functions contained in the files:
  /// <newpara></newpara>
  /// C:\Users\Seb Madgwick\Desktop\Automated Calibration Feasbility Study\Source Code
  /// and Resources\Calibration Algorithms MATLAB\calibrateAccelMag.m
  /// <newpara></newpara>
  /// C:\Users\Seb Madgwick\Desktop\Automated Calibration Feasbility Study\Source Code
  /// and Resources\Calibration Algorithms MATLAB\calibrateGyro.m
  /// <newpara></newpara>
  /// C:\Users\Seb Madgwick\Desktop\Automated Calibration Feasbility Study\Source Code
  /// and Resources\Calibration Algorithms MATLAB\objFunAccelMag.m
  /// <newpara></newpara>
  /// C:\Users\Seb Madgwick\Desktop\Automated Calibration Feasbility Study\Source Code
  /// and Resources\Calibration Algorithms MATLAB\objFunGyro.m
  /// <newpara></newpara>
  /// deployprint.m
  /// <newpara></newpara>
  /// printdlg.m
  /// </summary>
  /// <remarks>
  /// @Version 0.0
  /// </remarks>
  public class CalibrationAlgorithmsMATLABclass : IDisposable
    {
      #region Constructors

      /// <summary internal= "true">
      /// The static constructor instantiates and initializes the MATLAB Component
      /// Runtime instance.
      /// </summary>
      static CalibrationAlgorithmsMATLABclass()
        {
          if (MWArray.MCRAppInitialized)
            {
              Assembly assembly= Assembly.GetExecutingAssembly();

              string ctfFilePath= assembly.Location;

              int lastDelimeter= ctfFilePath.LastIndexOf(@"\");

              ctfFilePath= ctfFilePath.Remove(lastDelimeter, (ctfFilePath.Length - lastDelimeter));

              mcr= new MWMCR(MCRComponentState.MCC_CalibrationAlgorithmsMATLAB_name_data,
                             MCRComponentState.MCC_CalibrationAlgorithmsMATLAB_root_data,
                             MCRComponentState.MCC_CalibrationAlgorithmsMATLAB_public_data,
                             MCRComponentState.MCC_CalibrationAlgorithmsMATLAB_session_data,
                             MCRComponentState.MCC_CalibrationAlgorithmsMATLAB_matlabpath_data,
                             MCRComponentState.MCC_CalibrationAlgorithmsMATLAB_classpath_data,
                             MCRComponentState.MCC_CalibrationAlgorithmsMATLAB_libpath_data,
                             MCRComponentState.MCC_CalibrationAlgorithmsMATLAB_mcr_application_options,
                             MCRComponentState.MCC_CalibrationAlgorithmsMATLAB_mcr_runtime_options,
                             MCRComponentState.MCC_CalibrationAlgorithmsMATLAB_mcr_pref_dir,
                             MCRComponentState.MCC_CalibrationAlgorithmsMATLAB_set_warning_state,
                             ctfFilePath, true);
            }
          else
            {
              throw new ApplicationException("MWArray assembly could not be initialized");
            }
        }


      /// <summary>
      /// Constructs a new instance of the CalibrationAlgorithmsMATLABclass class.
      /// </summary>
      public CalibrationAlgorithmsMATLABclass()
        {
        }


      #endregion Constructors

      #region Finalize

      /// <summary internal= "true">
      /// Class destructor called by the CLR garbage collector.
      /// </summary>
      ~CalibrationAlgorithmsMATLABclass()
        {
          Dispose(false);
        }


      /// <summary>
      /// Frees the native resources associated with this object
      /// </summary>
      public void Dispose()
        {
          Dispose(true);

          GC.SuppressFinalize(this);
        }


      /// <summary internal= "true">
      /// Internal dispose function
      /// </summary>
      protected virtual void Dispose(bool disposing)
        {
          if (!disposed)
            {
              disposed= true;

              if (disposing)
                {
                  // Free managed resources;
                }

              // Free native resources
            }
        }


      #endregion Finalize

      #region Methods

      /// <summary>
      /// Provides a void output, 0-input interface to the calibrateAccelMag M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      ///
      public void calibrateAccelMag()
        {
          mcr.EvaluateFunction(0, "calibrateAccelMag");
        }


      /// <summary>
      /// Provides a void output, 1-input interface to the calibrateAccelMag M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      /// <param name="inFile">Input argument #1</param>
      ///
      public void calibrateAccelMag(MWArray inFile)
        {
          mcr.EvaluateFunction(0, "calibrateAccelMag", inFile);
        }


      /// <summary>
      /// Provides a void output, 2-input interface to the calibrateAccelMag M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      /// <param name="inFile">Input argument #1</param>
      /// <param name="outFile">Input argument #2</param>
      ///
      public void calibrateAccelMag(MWArray inFile, MWArray outFile)
        {
          mcr.EvaluateFunction(0, "calibrateAccelMag", inFile, outFile);
        }


      /// <summary>
      /// Provides a void output, 3-input interface to the calibrateAccelMag M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      /// <param name="inFile">Input argument #1</param>
      /// <param name="outFile">Input argument #2</param>
      /// <param name="accelElseMag">Input argument #3</param>
      ///
      public void calibrateAccelMag(MWArray inFile, MWArray outFile,
                                    MWArray accelElseMag)
        {
          mcr.EvaluateFunction(0, "calibrateAccelMag", inFile,
                                  outFile, accelElseMag);
        }


      /// <summary>
      /// Provides a void output, 4-input interface to the calibrateAccelMag M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      /// <param name="inFile">Input argument #1</param>
      /// <param name="outFile">Input argument #2</param>
      /// <param name="accelElseMag">Input argument #3</param>
      /// <param name="feildMagnitude">Input argument #4</param>
      ///
      public void calibrateAccelMag(MWArray inFile, MWArray outFile,
                                    MWArray accelElseMag,
                                    MWArray feildMagnitude)
        {
          mcr.EvaluateFunction(0, "calibrateAccelMag", inFile, outFile,
                                  accelElseMag, feildMagnitude);
        }


      /// <summary>
      /// Provides a void output, 5-input interface to the calibrateAccelMag M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      /// <param name="inFile">Input argument #1</param>
      /// <param name="outFile">Input argument #2</param>
      /// <param name="accelElseMag">Input argument #3</param>
      /// <param name="feildMagnitude">Input argument #4</param>
      /// <param name="bias">Input argument #5</param>
      ///
      public void calibrateAccelMag(MWArray inFile, MWArray outFile,
                                    MWArray accelElseMag,
                                    MWArray feildMagnitude, MWArray bias)
        {
          mcr.EvaluateFunction(0, "calibrateAccelMag", inFile, outFile,
                                  accelElseMag, feildMagnitude, bias);
        }


      /// <summary>
      /// Provides a void output, 6-input interface to the calibrateAccelMag M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      /// <param name="inFile">Input argument #1</param>
      /// <param name="outFile">Input argument #2</param>
      /// <param name="accelElseMag">Input argument #3</param>
      /// <param name="feildMagnitude">Input argument #4</param>
      /// <param name="bias">Input argument #5</param>
      /// <param name="gain">Input argument #6</param>
      ///
      public void calibrateAccelMag(MWArray inFile, MWArray outFile,
                                    MWArray accelElseMag,
                                    MWArray feildMagnitude,
                                    MWArray bias, MWArray gain)
        {
          mcr.EvaluateFunction(0, "calibrateAccelMag", inFile, outFile,
                                  accelElseMag, feildMagnitude, bias, gain);
        }


      /// <summary>
      /// Provides the standard 0-input interface to the calibrateAccelMag M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return.</param>
      /// <returns>An Array of length "numArgsOut" containing the output
      /// arguments.</returns>
      ///
      public MWArray[] calibrateAccelMag(int numArgsOut)
        {
          return mcr.EvaluateFunction(numArgsOut, "calibrateAccelMag");
        }


      /// <summary>
      /// Provides the standard 1-input interface to the calibrateAccelMag M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return.</param>
      /// <param name="inFile">Input argument #1</param>
      /// <returns>An Array of length "numArgsOut" containing the output
      /// arguments.</returns>
      ///
      public MWArray[] calibrateAccelMag(int numArgsOut, MWArray inFile)
        {
          return mcr.EvaluateFunction(numArgsOut, "calibrateAccelMag", inFile);
        }


      /// <summary>
      /// Provides the standard 2-input interface to the calibrateAccelMag M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return.</param>
      /// <param name="inFile">Input argument #1</param>
      /// <param name="outFile">Input argument #2</param>
      /// <returns>An Array of length "numArgsOut" containing the output
      /// arguments.</returns>
      ///
      public MWArray[] calibrateAccelMag(int numArgsOut, MWArray inFile,
                                         MWArray outFile)
        {
          return mcr.EvaluateFunction(numArgsOut, "calibrateAccelMag",
                                      inFile, outFile);
        }


      /// <summary>
      /// Provides the standard 3-input interface to the calibrateAccelMag M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return.</param>
      /// <param name="inFile">Input argument #1</param>
      /// <param name="outFile">Input argument #2</param>
      /// <param name="accelElseMag">Input argument #3</param>
      /// <returns>An Array of length "numArgsOut" containing the output
      /// arguments.</returns>
      ///
      public MWArray[] calibrateAccelMag(int numArgsOut, MWArray inFile,
                                         MWArray outFile, MWArray accelElseMag)
        {
          return mcr.EvaluateFunction(numArgsOut, "calibrateAccelMag",
                                      inFile, outFile, accelElseMag);
        }


      /// <summary>
      /// Provides the standard 4-input interface to the calibrateAccelMag M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return.</param>
      /// <param name="inFile">Input argument #1</param>
      /// <param name="outFile">Input argument #2</param>
      /// <param name="accelElseMag">Input argument #3</param>
      /// <param name="feildMagnitude">Input argument #4</param>
      /// <returns>An Array of length "numArgsOut" containing the output
      /// arguments.</returns>
      ///
      public MWArray[] calibrateAccelMag(int numArgsOut, MWArray inFile,
                                         MWArray outFile, MWArray accelElseMag,
                                         MWArray feildMagnitude)
        {
          return mcr.EvaluateFunction(numArgsOut, "calibrateAccelMag", inFile,
                                      outFile, accelElseMag, feildMagnitude);
        }


      /// <summary>
      /// Provides the standard 5-input interface to the calibrateAccelMag M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return.</param>
      /// <param name="inFile">Input argument #1</param>
      /// <param name="outFile">Input argument #2</param>
      /// <param name="accelElseMag">Input argument #3</param>
      /// <param name="feildMagnitude">Input argument #4</param>
      /// <param name="bias">Input argument #5</param>
      /// <returns>An Array of length "numArgsOut" containing the output
      /// arguments.</returns>
      ///
      public MWArray[] calibrateAccelMag(int numArgsOut, MWArray inFile,
                                         MWArray outFile, MWArray accelElseMag,
                                         MWArray feildMagnitude, MWArray bias)
        {
          return mcr.EvaluateFunction(numArgsOut, "calibrateAccelMag",
                                      inFile, outFile, accelElseMag,
                                      feildMagnitude, bias);
        }


      /// <summary>
      /// Provides the standard 6-input interface to the calibrateAccelMag M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return.</param>
      /// <param name="inFile">Input argument #1</param>
      /// <param name="outFile">Input argument #2</param>
      /// <param name="accelElseMag">Input argument #3</param>
      /// <param name="feildMagnitude">Input argument #4</param>
      /// <param name="bias">Input argument #5</param>
      /// <param name="gain">Input argument #6</param>
      /// <returns>An Array of length "numArgsOut" containing the output
      /// arguments.</returns>
      ///
      public MWArray[] calibrateAccelMag(int numArgsOut, MWArray inFile,
                                         MWArray outFile, MWArray accelElseMag,
                                         MWArray feildMagnitude, MWArray bias,
                                         MWArray gain)
        {
          return mcr.EvaluateFunction(numArgsOut, "calibrateAccelMag",
                                      inFile, outFile, accelElseMag,
                                      feildMagnitude, bias, gain);
        }


      /// <summary>
      /// Provides a void output, 0-input interface to the calibrateGyro M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      ///
      public void calibrateGyro()
        {
          mcr.EvaluateFunction(0, "calibrateGyro");
        }


      /// <summary>
      /// Provides a void output, 1-input interface to the calibrateGyro M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      /// <param name="inFile">Input argument #1</param>
      ///
      public void calibrateGyro(MWArray inFile)
        {
          mcr.EvaluateFunction(0, "calibrateGyro", inFile);
        }


      /// <summary>
      /// Provides a void output, 2-input interface to the calibrateGyro M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      /// <param name="inFile">Input argument #1</param>
      /// <param name="outFile">Input argument #2</param>
      ///
      public void calibrateGyro(MWArray inFile, MWArray outFile)
        {
          mcr.EvaluateFunction(0, "calibrateGyro", inFile, outFile);
        }


      /// <summary>
      /// Provides a void output, 3-input interface to the calibrateGyro M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      /// <param name="inFile">Input argument #1</param>
      /// <param name="outFile">Input argument #2</param>
      /// <param name="axis">Input argument #3</param>
      ///
      public void calibrateGyro(MWArray inFile, MWArray outFile, MWArray axis)
        {
          mcr.EvaluateFunction(0, "calibrateGyro", inFile, outFile, axis);
        }


      /// <summary>
      /// Provides a void output, 4-input interface to the calibrateGyro M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      /// <param name="inFile">Input argument #1</param>
      /// <param name="outFile">Input argument #2</param>
      /// <param name="axis">Input argument #3</param>
      /// <param name="target">Input argument #4</param>
      ///
      public void calibrateGyro(MWArray inFile, MWArray outFile,
                                MWArray axis, MWArray target)
        {
          mcr.EvaluateFunction(0, "calibrateGyro", inFile,
                                  outFile, axis, target);
        }


      /// <summary>
      /// Provides a void output, 5-input interface to the calibrateGyro M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      /// <param name="inFile">Input argument #1</param>
      /// <param name="outFile">Input argument #2</param>
      /// <param name="axis">Input argument #3</param>
      /// <param name="target">Input argument #4</param>
      /// <param name="samplePeriod">Input argument #5</param>
      ///
      public void calibrateGyro(MWArray inFile, MWArray outFile, MWArray axis,
                                MWArray target, MWArray samplePeriod)
        {
          mcr.EvaluateFunction(0, "calibrateGyro", inFile, outFile,
                                  axis, target, samplePeriod);
        }


      /// <summary>
      /// Provides a void output, 6-input interface to the calibrateGyro M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      /// <param name="inFile">Input argument #1</param>
      /// <param name="outFile">Input argument #2</param>
      /// <param name="axis">Input argument #3</param>
      /// <param name="target">Input argument #4</param>
      /// <param name="samplePeriod">Input argument #5</param>
      /// <param name="gain">Input argument #6</param>
      ///
      public void calibrateGyro(MWArray inFile, MWArray outFile,
                                MWArray axis, MWArray target,
                                MWArray samplePeriod, MWArray gain)
        {
          mcr.EvaluateFunction(0, "calibrateGyro", inFile, outFile,
                                  axis, target, samplePeriod, gain);
        }


      /// <summary>
      /// Provides the standard 0-input interface to the calibrateGyro M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return.</param>
      /// <returns>An Array of length "numArgsOut" containing the output
      /// arguments.</returns>
      ///
      public MWArray[] calibrateGyro(int numArgsOut)
        {
          return mcr.EvaluateFunction(numArgsOut, "calibrateGyro");
        }


      /// <summary>
      /// Provides the standard 1-input interface to the calibrateGyro M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return.</param>
      /// <param name="inFile">Input argument #1</param>
      /// <returns>An Array of length "numArgsOut" containing the output
      /// arguments.</returns>
      ///
      public MWArray[] calibrateGyro(int numArgsOut, MWArray inFile)
        {
          return mcr.EvaluateFunction(numArgsOut, "calibrateGyro", inFile);
        }


      /// <summary>
      /// Provides the standard 2-input interface to the calibrateGyro M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return.</param>
      /// <param name="inFile">Input argument #1</param>
      /// <param name="outFile">Input argument #2</param>
      /// <returns>An Array of length "numArgsOut" containing the output
      /// arguments.</returns>
      ///
      public MWArray[] calibrateGyro(int numArgsOut, MWArray inFile,
                                     MWArray outFile)
        {
          return mcr.EvaluateFunction(numArgsOut, "calibrateGyro",
                                      inFile, outFile);
        }


      /// <summary>
      /// Provides the standard 3-input interface to the calibrateGyro M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return.</param>
      /// <param name="inFile">Input argument #1</param>
      /// <param name="outFile">Input argument #2</param>
      /// <param name="axis">Input argument #3</param>
      /// <returns>An Array of length "numArgsOut" containing the output
      /// arguments.</returns>
      ///
      public MWArray[] calibrateGyro(int numArgsOut, MWArray inFile,
                                     MWArray outFile, MWArray axis)
        {
          return mcr.EvaluateFunction(numArgsOut, "calibrateGyro",
                                      inFile, outFile, axis);
        }


      /// <summary>
      /// Provides the standard 4-input interface to the calibrateGyro M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return.</param>
      /// <param name="inFile">Input argument #1</param>
      /// <param name="outFile">Input argument #2</param>
      /// <param name="axis">Input argument #3</param>
      /// <param name="target">Input argument #4</param>
      /// <returns>An Array of length "numArgsOut" containing the output
      /// arguments.</returns>
      ///
      public MWArray[] calibrateGyro(int numArgsOut, MWArray inFile,
                                     MWArray outFile, MWArray axis,
                                     MWArray target)
        {
          return mcr.EvaluateFunction(numArgsOut, "calibrateGyro",
                                      inFile, outFile, axis, target);
        }


      /// <summary>
      /// Provides the standard 5-input interface to the calibrateGyro M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return.</param>
      /// <param name="inFile">Input argument #1</param>
      /// <param name="outFile">Input argument #2</param>
      /// <param name="axis">Input argument #3</param>
      /// <param name="target">Input argument #4</param>
      /// <param name="samplePeriod">Input argument #5</param>
      /// <returns>An Array of length "numArgsOut" containing the output
      /// arguments.</returns>
      ///
      public MWArray[] calibrateGyro(int numArgsOut, MWArray inFile,
                                     MWArray outFile, MWArray axis,
                                     MWArray target, MWArray samplePeriod)
        {
          return mcr.EvaluateFunction(numArgsOut, "calibrateGyro", inFile,
                                      outFile, axis, target, samplePeriod);
        }


      /// <summary>
      /// Provides the standard 6-input interface to the calibrateGyro M-function.
      /// </summary>
      /// <remarks>
      /// M-Documentation:
      /// --------------------------------------------------------------------------  
      /// Import data
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return.</param>
      /// <param name="inFile">Input argument #1</param>
      /// <param name="outFile">Input argument #2</param>
      /// <param name="axis">Input argument #3</param>
      /// <param name="target">Input argument #4</param>
      /// <param name="samplePeriod">Input argument #5</param>
      /// <param name="gain">Input argument #6</param>
      /// <returns>An Array of length "numArgsOut" containing the output
      /// arguments.</returns>
      ///
      public MWArray[] calibrateGyro(int numArgsOut, MWArray inFile,
                                     MWArray outFile, MWArray axis,
                                     MWArray target,
                                     MWArray samplePeriod, MWArray gain)
        {
          return mcr.EvaluateFunction(numArgsOut, "calibrateGyro",
                                      inFile, outFile, axis,
                                      target, samplePeriod, gain);
        }


      /// <summary>
      /// Provides a single output, 0-input interface to the objFunAccelMag M-function.
      /// </summary>
      /// <remarks>
      /// </remarks>
      /// <returns>An MWArray containing the first output argument.</returns>
      ///
      public MWArray objFunAccelMag()
        {
          return mcr.EvaluateFunction("objFunAccelMag");
        }


      /// <summary>
      /// Provides a single output, 1-input interface to the objFunAccelMag M-function.
      /// </summary>
      /// <remarks>
      /// </remarks>
      /// <param name="optVal">Input argument #1</param>
      /// <returns>An MWArray containing the first output argument.</returns>
      ///
      public MWArray objFunAccelMag(MWArray optVal)
        {
          return mcr.EvaluateFunction("objFunAccelMag", optVal);
        }


      /// <summary>
      /// Provides a single output, 2-input interface to the objFunAccelMag M-function.
      /// </summary>
      /// <remarks>
      /// </remarks>
      /// <param name="optVal">Input argument #1</param>
      /// <param name="optValScaler">Input argument #2</param>
      /// <returns>An MWArray containing the first output argument.</returns>
      ///
      public MWArray objFunAccelMag(MWArray optVal, MWArray optValScaler)
        {
          return mcr.EvaluateFunction("objFunAccelMag", optVal, optValScaler);
        }


      /// <summary>
      /// Provides a single output, 3-input interface to the objFunAccelMag M-function.
      /// </summary>
      /// <remarks>
      /// </remarks>
      /// <param name="optVal">Input argument #1</param>
      /// <param name="optValScaler">Input argument #2</param>
      /// <param name="data">Input argument #3</param>
      /// <returns>An MWArray containing the first output argument.</returns>
      ///
      public MWArray objFunAccelMag(MWArray optVal,
                                    MWArray optValScaler, MWArray data)
        {
          return mcr.EvaluateFunction("objFunAccelMag", optVal,
                                      optValScaler, data);
        }


      /// <summary>
      /// Provides a single output, 4-input interface to the objFunAccelMag M-function.
      /// </summary>
      /// <remarks>
      /// </remarks>
      /// <param name="optVal">Input argument #1</param>
      /// <param name="optValScaler">Input argument #2</param>
      /// <param name="data">Input argument #3</param>
      /// <param name="magnitude">Input argument #4</param>
      /// <returns>An MWArray containing the first output argument.</returns>
      ///
      public MWArray objFunAccelMag(MWArray optVal, MWArray optValScaler,
                                    MWArray data, MWArray magnitude)
        {
          return mcr.EvaluateFunction("objFunAccelMag", optVal,
                                      optValScaler, data, magnitude);
        }


      /// <summary>
      /// Provides the standard 0-input interface to the objFunAccelMag M-function.
      /// </summary>
      /// <remarks>
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return.</param>
      /// <returns>An Array of length "numArgsOut" containing the output
      /// arguments.</returns>
      ///
      public MWArray[] objFunAccelMag(int numArgsOut)
        {
          return mcr.EvaluateFunction(numArgsOut, "objFunAccelMag");
        }


      /// <summary>
      /// Provides the standard 1-input interface to the objFunAccelMag M-function.
      /// </summary>
      /// <remarks>
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return.</param>
      /// <param name="optVal">Input argument #1</param>
      /// <returns>An Array of length "numArgsOut" containing the output
      /// arguments.</returns>
      ///
      public MWArray[] objFunAccelMag(int numArgsOut, MWArray optVal)
        {
          return mcr.EvaluateFunction(numArgsOut, "objFunAccelMag", optVal);
        }


      /// <summary>
      /// Provides the standard 2-input interface to the objFunAccelMag M-function.
      /// </summary>
      /// <remarks>
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return.</param>
      /// <param name="optVal">Input argument #1</param>
      /// <param name="optValScaler">Input argument #2</param>
      /// <returns>An Array of length "numArgsOut" containing the output
      /// arguments.</returns>
      ///
      public MWArray[] objFunAccelMag(int numArgsOut, MWArray optVal,
                                      MWArray optValScaler)
        {
          return mcr.EvaluateFunction(numArgsOut, "objFunAccelMag",
                                      optVal, optValScaler);
        }


      /// <summary>
      /// Provides the standard 3-input interface to the objFunAccelMag M-function.
      /// </summary>
      /// <remarks>
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return.</param>
      /// <param name="optVal">Input argument #1</param>
      /// <param name="optValScaler">Input argument #2</param>
      /// <param name="data">Input argument #3</param>
      /// <returns>An Array of length "numArgsOut" containing the output
      /// arguments.</returns>
      ///
      public MWArray[] objFunAccelMag(int numArgsOut, MWArray optVal,
                                      MWArray optValScaler, MWArray data)
        {
          return mcr.EvaluateFunction(numArgsOut, "objFunAccelMag",
                                      optVal, optValScaler, data);
        }


      /// <summary>
      /// Provides the standard 4-input interface to the objFunAccelMag M-function.
      /// </summary>
      /// <remarks>
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return.</param>
      /// <param name="optVal">Input argument #1</param>
      /// <param name="optValScaler">Input argument #2</param>
      /// <param name="data">Input argument #3</param>
      /// <param name="magnitude">Input argument #4</param>
      /// <returns>An Array of length "numArgsOut" containing the output
      /// arguments.</returns>
      ///
      public MWArray[] objFunAccelMag(int numArgsOut, MWArray optVal,
                                      MWArray optValScaler,
                                      MWArray data, MWArray magnitude)
        {
          return mcr.EvaluateFunction(numArgsOut, "objFunAccelMag", optVal,
                                      optValScaler, data, magnitude);
        }


      /// <summary>
      /// Provides an interface for the objFunAccelMag function in which the input and
      /// output
      /// arguments are specified as an array of MWArrays.
      /// </summary>
      /// <remarks>
      /// This method will allocate and return by reference the output argument
      /// array.<newpara></newpara>
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return</param>
      /// <param name= "argsOut">Array of MWArray output arguments</param>
      /// <param name= "argsIn">Array of MWArray input arguments</param>
      ///
      public void objFunAccelMag(int numArgsOut, ref MWArray[] argsOut,
                           MWArray[] argsIn)
        {
          mcr.EvaluateFunction("objFunAccelMag", numArgsOut, ref argsOut, argsIn);
        }


      /// <summary>
      /// Provides a single output, 0-input interface to the objFunGyro M-function.
      /// </summary>
      /// <remarks>
      /// </remarks>
      /// <returns>An MWArray containing the first output argument.</returns>
      ///
      public MWArray objFunGyro()
        {
          return mcr.EvaluateFunction("objFunGyro");
        }


      /// <summary>
      /// Provides a single output, 1-input interface to the objFunGyro M-function.
      /// </summary>
      /// <remarks>
      /// </remarks>
      /// <param name="optVal">Input argument #1</param>
      /// <returns>An MWArray containing the first output argument.</returns>
      ///
      public MWArray objFunGyro(MWArray optVal)
        {
          return mcr.EvaluateFunction("objFunGyro", optVal);
        }


      /// <summary>
      /// Provides a single output, 2-input interface to the objFunGyro M-function.
      /// </summary>
      /// <remarks>
      /// </remarks>
      /// <param name="optVal">Input argument #1</param>
      /// <param name="optValScaler">Input argument #2</param>
      /// <returns>An MWArray containing the first output argument.</returns>
      ///
      public MWArray objFunGyro(MWArray optVal, MWArray optValScaler)
        {
          return mcr.EvaluateFunction("objFunGyro", optVal, optValScaler);
        }


      /// <summary>
      /// Provides a single output, 3-input interface to the objFunGyro M-function.
      /// </summary>
      /// <remarks>
      /// </remarks>
      /// <param name="optVal">Input argument #1</param>
      /// <param name="optValScaler">Input argument #2</param>
      /// <param name="data">Input argument #3</param>
      /// <returns>An MWArray containing the first output argument.</returns>
      ///
      public MWArray objFunGyro(MWArray optVal,
                                MWArray optValScaler, MWArray data)
        {
          return mcr.EvaluateFunction("objFunGyro", optVal, optValScaler, data);
        }


      /// <summary>
      /// Provides a single output, 4-input interface to the objFunGyro M-function.
      /// </summary>
      /// <remarks>
      /// </remarks>
      /// <param name="optVal">Input argument #1</param>
      /// <param name="optValScaler">Input argument #2</param>
      /// <param name="data">Input argument #3</param>
      /// <param name="target">Input argument #4</param>
      /// <returns>An MWArray containing the first output argument.</returns>
      ///
      public MWArray objFunGyro(MWArray optVal, MWArray optValScaler,
                                MWArray data, MWArray target)
        {
          return mcr.EvaluateFunction("objFunGyro", optVal,
                                      optValScaler, data, target);
        }


      /// <summary>
      /// Provides a single output, 5-input interface to the objFunGyro M-function.
      /// </summary>
      /// <remarks>
      /// </remarks>
      /// <param name="optVal">Input argument #1</param>
      /// <param name="optValScaler">Input argument #2</param>
      /// <param name="data">Input argument #3</param>
      /// <param name="target">Input argument #4</param>
      /// <param name="samplePeriod">Input argument #5</param>
      /// <returns>An MWArray containing the first output argument.</returns>
      ///
      public MWArray objFunGyro(MWArray optVal, MWArray optValScaler,
                                MWArray data, MWArray target,
                                MWArray samplePeriod)
        {
          return mcr.EvaluateFunction("objFunGyro", optVal, optValScaler,
                                      data, target, samplePeriod);
        }


      /// <summary>
      /// Provides the standard 0-input interface to the objFunGyro M-function.
      /// </summary>
      /// <remarks>
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return.</param>
      /// <returns>An Array of length "numArgsOut" containing the output
      /// arguments.</returns>
      ///
      public MWArray[] objFunGyro(int numArgsOut)
        {
          return mcr.EvaluateFunction(numArgsOut, "objFunGyro");
        }


      /// <summary>
      /// Provides the standard 1-input interface to the objFunGyro M-function.
      /// </summary>
      /// <remarks>
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return.</param>
      /// <param name="optVal">Input argument #1</param>
      /// <returns>An Array of length "numArgsOut" containing the output
      /// arguments.</returns>
      ///
      public MWArray[] objFunGyro(int numArgsOut, MWArray optVal)
        {
          return mcr.EvaluateFunction(numArgsOut, "objFunGyro", optVal);
        }


      /// <summary>
      /// Provides the standard 2-input interface to the objFunGyro M-function.
      /// </summary>
      /// <remarks>
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return.</param>
      /// <param name="optVal">Input argument #1</param>
      /// <param name="optValScaler">Input argument #2</param>
      /// <returns>An Array of length "numArgsOut" containing the output
      /// arguments.</returns>
      ///
      public MWArray[] objFunGyro(int numArgsOut, MWArray optVal,
                                  MWArray optValScaler)
        {
          return mcr.EvaluateFunction(numArgsOut, "objFunGyro",
                                      optVal, optValScaler);
        }


      /// <summary>
      /// Provides the standard 3-input interface to the objFunGyro M-function.
      /// </summary>
      /// <remarks>
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return.</param>
      /// <param name="optVal">Input argument #1</param>
      /// <param name="optValScaler">Input argument #2</param>
      /// <param name="data">Input argument #3</param>
      /// <returns>An Array of length "numArgsOut" containing the output
      /// arguments.</returns>
      ///
      public MWArray[] objFunGyro(int numArgsOut, MWArray optVal,
                                  MWArray optValScaler, MWArray data)
        {
          return mcr.EvaluateFunction(numArgsOut, "objFunGyro",
                                      optVal, optValScaler, data);
        }


      /// <summary>
      /// Provides the standard 4-input interface to the objFunGyro M-function.
      /// </summary>
      /// <remarks>
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return.</param>
      /// <param name="optVal">Input argument #1</param>
      /// <param name="optValScaler">Input argument #2</param>
      /// <param name="data">Input argument #3</param>
      /// <param name="target">Input argument #4</param>
      /// <returns>An Array of length "numArgsOut" containing the output
      /// arguments.</returns>
      ///
      public MWArray[] objFunGyro(int numArgsOut, MWArray optVal,
                                  MWArray optValScaler,
                                  MWArray data, MWArray target)
        {
          return mcr.EvaluateFunction(numArgsOut, "objFunGyro", optVal,
                                      optValScaler, data, target);
        }


      /// <summary>
      /// Provides the standard 5-input interface to the objFunGyro M-function.
      /// </summary>
      /// <remarks>
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return.</param>
      /// <param name="optVal">Input argument #1</param>
      /// <param name="optValScaler">Input argument #2</param>
      /// <param name="data">Input argument #3</param>
      /// <param name="target">Input argument #4</param>
      /// <param name="samplePeriod">Input argument #5</param>
      /// <returns>An Array of length "numArgsOut" containing the output
      /// arguments.</returns>
      ///
      public MWArray[] objFunGyro(int numArgsOut, MWArray optVal,
                                  MWArray optValScaler, MWArray data,
                                  MWArray target, MWArray samplePeriod)
        {
          return mcr.EvaluateFunction(numArgsOut, "objFunGyro", optVal,
                                      optValScaler, data, target, samplePeriod);
        }


      /// <summary>
      /// Provides an interface for the objFunGyro function in which the input and output
      /// arguments are specified as an array of MWArrays.
      /// </summary>
      /// <remarks>
      /// This method will allocate and return by reference the output argument
      /// array.<newpara></newpara>
      /// </remarks>
      /// <param name="numArgsOut">The number of output arguments to return</param>
      /// <param name= "argsOut">Array of MWArray output arguments</param>
      /// <param name= "argsIn">Array of MWArray input arguments</param>
      ///
      public void objFunGyro(int numArgsOut, ref MWArray[] argsOut, MWArray[] argsIn)
        {
          mcr.EvaluateFunction("objFunGyro", numArgsOut, ref argsOut, argsIn);
        }


      /// <summary>
      /// This method will cause a MATLAB figure window to behave as a modal dialog box.
      /// The method will not return until all the figure windows associated with this
      /// component have been closed.
      /// </summary>
      /// <remarks>
      /// An application should only call this method when required to keep the
      /// MATLAB figure window from disappearing.  Other techniques, such as calling
      /// Console.ReadLine() from the application should be considered where
      /// possible.</remarks>
      ///
      public void WaitForFiguresToDie()
        {
          mcr.WaitForFiguresToDie();
        }


      
      #endregion Methods

      #region Class Members

      private static MWMCR mcr= null;

      private bool disposed= false;

      #endregion Class Members
    }
}

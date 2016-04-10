/*
 * Kalman.h
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "Kalman".
 *
 * Model version              : 1.152
 * Simulink Coder version : 8.8.1 (R2015aSP1) 04-Sep-2015
 * C++ source code generated on : Wed Apr 06 13:18:35 2016
 *
 * Target selection: grt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: ARM Compatible->ARM Cortex
 * Code generation objective: Execution efficiency
 * Validation result: Not run
 */

#ifndef RTW_HEADER_Kalman_h_
#define RTW_HEADER_Kalman_h_
#include <math.h>
#include <string.h>
#include <stddef.h>
#ifndef Kalman_COMMON_INCLUDES_
# define Kalman_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "rtw_continuous.h"
#include "rtw_solver.h"
#endif                                 /* Kalman_COMMON_INCLUDES_ */

#include "Kalman_types.h"

/* Shared type includes */
#include "multiword_types.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetErrorStatus
# define rtmGetErrorStatus(rtm)        ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
# define rtmSetErrorStatus(rtm, val)   ((rtm)->errorStatus = (val))
#endif

/* Block states (auto storage) for system '<Root>' */
typedef struct {
  real_T UnitDelay_DSTATE[36];         /* '<Root>/Unit Delay' */
  real_T UnitDelay2_DSTATE[4];         /* '<Root>/Unit Delay2' */
  real_T UnitDelay1_DSTATE[3];         /* '<Root>/Unit Delay1' */
  real_T UnitDelay3_DSTATE[3];         /* '<Root>/Unit Delay3' */
} DW_Kalman_T;

/* External inputs (root inport signals with auto storage) */
typedef struct {
  real_T gx;                           /* '<Root>/gx' */
  real_T gy;                           /* '<Root>/gy' */
  real_T gz;                           /* '<Root>/gz' */
  real_T ax;                           /* '<Root>/ax' */
  real_T ay;                           /* '<Root>/ay' */
  real_T az;                           /* '<Root>/az' */
  real_T mx;                           /* '<Root>/mx' */
  real_T my;                           /* '<Root>/my' */
  real_T mz;                           /* '<Root>/mz' */
} ExtU_Kalman_T;

/* External outputs (root outports fed by signals with auto storage) */
typedef struct {
  real_T Quaternion[4];                /* '<Root>/Quaternion' */
  real_T OmegaHat[3];                  /* '<Root>/OmegaHat' */
  real_T RPY[3];                       /* '<Root>/RPY' */
  real_T beta[3];                      /* '<Root>/beta ' */
} ExtY_Kalman_T;

/* Parameters (auto storage) */
struct P_Kalman_T_ {
  real_T UnitDelay_InitialCondition[36];/* Expression: (1e-6)*[1 0 0 0 0 0; 0 1 0 0 0 0; 0 0 1 0 0 0; 0 0 0 1 0 0; 0 0 0 0 1 0; 0 0 0 0 0 1]
                                         * Referenced by: '<Root>/Unit Delay'
                                         */
  real_T UnitDelay2_InitialCondition[4];/* Expression: [0 0 0 1]'
                                         * Referenced by: '<Root>/Unit Delay2'
                                         */
  real_T UnitDelay1_InitialCondition[3];/* Expression: 0.00001*[1 1 1]'
                                         * Referenced by: '<Root>/Unit Delay1'
                                         */
  real_T UnitDelay3_InitialCondition[3];/* Expression: 0.00001*[1 1 1]'
                                         * Referenced by: '<Root>/Unit Delay3'
                                         */
};

/* Real-time Model Data Structure */
struct tag_RTM_Kalman_T {
  const char_T *errorStatus;
};

#ifdef __cplusplus

extern "C" {

#endif

#ifdef __cplusplus

}
#endif

/* Class declaration for model Kalman */
class KalmanModelClass {
  /* public data and function members */
 public:
  /* External inputs */
  ExtU_Kalman_T Kalman_U;

  /* External outputs */
  ExtY_Kalman_T Kalman_Y;

  /* Model entry point functions */

  /* model initialize function */
  void initialize();

  /* model step function */
  void step();

  /* model terminate function */
  void terminate();

  /* Constructor */
  KalmanModelClass();

  /* Destructor */
  ~KalmanModelClass();

  /* Real-Time Model get method */
  RT_MODEL_Kalman_T * getRTM();

  /* private data and function members */
 private:
  /* Tunable parameters */
  P_Kalman_T Kalman_P;

  /* Block states */
  DW_Kalman_T Kalman_DW;

  /* Real-Time Model */
  RT_MODEL_Kalman_T Kalman_M;

  /* private member function(s) for subsystem '<Root>' */
  void Kalman_mrdivide(const real_T A[18], const real_T B[9], real_T y[18]);
};

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'Kalman'
 * '<S1>'   : 'Kalman/Propagation '
 * '<S2>'   : 'Kalman/Update'
 */
#endif                                 /* RTW_HEADER_Kalman_h_ */

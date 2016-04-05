/*
 * Kalman.cpp
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "Kalman".
 *
 * Model version              : 1.151
 * Simulink Coder version : 8.8.1 (R2015aSP1) 04-Sep-2015
 * C++ source code generated on : Wed Apr 06 00:18:35 2016
 *
 * Target selection: grt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: ARM Compatible->ARM Cortex
 * Code generation objective: Execution efficiency
 * Validation result: Not run
 */

#include "Kalman.h"
#include "Kalman_private.h"

/* Function for MATLAB Function: '<Root>/Update' */
void KalmanModelClass::Kalman_mrdivide(const real_T A[18], const real_T B[9],
  real_T y[18])
{
  real_T b_A[9];
  int32_T r1;
  int32_T r2;
  int32_T r3;
  real_T maxval;
  real_T a21;
  int32_T rtemp;
  memcpy(&b_A[0], &B[0], 9U * sizeof(real_T));
  r1 = 0;
  r2 = 1;
  r3 = 2;
  maxval = fabs(B[0]);
  a21 = fabs(B[1]);
  if (a21 > maxval) {
    maxval = a21;
    r1 = 1;
    r2 = 0;
  }

  if (fabs(B[2]) > maxval) {
    r1 = 2;
    r2 = 1;
    r3 = 0;
  }

  b_A[r2] = B[r2] / B[r1];
  b_A[r3] /= b_A[r1];
  b_A[3 + r2] -= b_A[3 + r1] * b_A[r2];
  b_A[3 + r3] -= b_A[3 + r1] * b_A[r3];
  b_A[6 + r2] -= b_A[6 + r1] * b_A[r2];
  b_A[6 + r3] -= b_A[6 + r1] * b_A[r3];
  if (fabs(b_A[3 + r3]) > fabs(b_A[3 + r2])) {
    rtemp = r2;
    r2 = r3;
    r3 = rtemp;
  }

  b_A[3 + r3] /= b_A[3 + r2];
  b_A[6 + r3] -= b_A[3 + r3] * b_A[6 + r2];
  for (rtemp = 0; rtemp < 6; rtemp++) {
    y[rtemp + 6 * r1] = A[rtemp] / b_A[r1];
    y[rtemp + 6 * r2] = A[6 + rtemp] - y[6 * r1 + rtemp] * b_A[3 + r1];
    y[rtemp + 6 * r3] = A[12 + rtemp] - y[6 * r1 + rtemp] * b_A[6 + r1];
    y[rtemp + 6 * r2] /= b_A[3 + r2];
    y[rtemp + 6 * r3] -= y[6 * r2 + rtemp] * b_A[6 + r2];
    y[rtemp + 6 * r3] /= b_A[6 + r3];
    y[rtemp + 6 * r2] -= y[6 * r3 + rtemp] * b_A[3 + r3];
    y[rtemp + 6 * r1] -= y[6 * r3 + rtemp] * b_A[r3];
    y[rtemp + 6 * r1] -= y[6 * r2 + rtemp] * b_A[r2];
  }
}

/* Model step function */
void KalmanModelClass::step()
{
  int8_T I[16];
  static const real_T y[36] = { 1.6354441633333335E-12, 0.0, 0.0,
    -9.5316624499999987E-11, 0.0, 0.0, 0.0, 1.4072293633333337E-12, 0.0, 0.0,
    -6.10844045E-11, 0.0, 0.0, 0.0, 2.5000000001358222E-5, 0.0, 0.0,
    -2.0373259445000002E-13, -9.5316624499999987E-11, 0.0, 0.0, 1.90633249E-8,
    0.0, 0.0, 0.0, -6.10844045E-11, 0.0, 0.0, 1.2216880900000001E-8, 0.0, 0.0,
    0.0, -2.0373259445000002E-13, 0.0, 0.0, 4.074651889E-11 };

  static const real_T b[36] = { 1.0, 0.0, 0.0, -0.01, -0.0, -0.0, 0.0, 1.0, 0.0,
    -0.0, -0.01, -0.0, 0.0, 0.0, 1.0, -0.0, -0.0, -0.01, 0.0, 0.0, 0.0, 1.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0 };

  static const real_T a[36] = { 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, -0.01, -0.0, -0.0, 1.0, 0.0, 0.0,
    -0.0, -0.01, -0.0, 0.0, 1.0, 0.0, -0.0, -0.0, -0.01, 0.0, 0.0, 1.0 };

  real_T Pkp[36];
  real_T Magnetometer[3];
  real_T Aqkm[9];
  real_T Aqmr[3];
  real_T Hk[18];
  real_T Kk[18];
  real_T deltaXkp[6];
  static const real_T R[9] = { 259.21322001000004, 0.0, 0.0, 0.0,
    106.39097316000002, 0.0, 0.0, 0.0, 454.38038244000006 };

  static const real_T b_R[9] = { 0.5993546724, 0.0, 0.0, 0.0,
    0.44804280959999992, 0.0, 0.0, 0.0, 0.5110105225 };

  static const int8_T b_b[9] = { 1, 0, 0, 0, 1, 0, 0, 0, 1 };

  static const int8_T I6[36] = { 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0,
    0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1 };

  real_T rtb_TmpSignalConversionAtSFun_l[3];
  real_T rtb_TmpSignalConversionAtSFun_n[3];
  real_T rtb_qkm[4];
  real_T rtb_Pkm[36];
  real_T rtb_Pkm_0[18];
  int32_T i;
  real_T tmp[16];
  real_T I_0[16];
  real_T a_0[36];
  real_T rtb_TmpSignalConversionAtSFun_0[9];
  real_T tmp_0[9];
  real_T I6_0[36];
  real_T Magnetometer_0[3];
  int32_T i_0;
  int32_T i_1;
  real_T rtb_qkm_p;
  real_T dq_idx_3;
  real_T rtb_qkp_idx_0;
  real_T dq_idx_0;
  real_T dq_idx_1;
  real_T dq_idx_2;
  real_T rtb_qkp_idx_1;
  real_T rtb_qkp_idx_2;

  /* MATLAB Function: '<Root>/Propagation ' incorporates:
   *  UnitDelay: '<Root>/Unit Delay'
   *  UnitDelay: '<Root>/Unit Delay1'
   *  UnitDelay: '<Root>/Unit Delay2'
   */
  /* MATLAB Function 'Propagation ': '<S1>:1' */
  /* % EKF - Propagation      % */
  /*  Author: Mattia Giurato  % */
  /*  Last review: 2016/03/15 % */
  /* %%%%%%%%%%%%%%%%%%%%%%%%%% */
  /* % Usefull values */
  /* % Quaternion propagation */
  /* '<S1>:1:14' */
  /* '<S1>:1:17' */
  /* '<S1>:1:19' */
  for (i = 0; i < 16; i++) {
    I[i] = 0;
  }

  I[0] = 1;
  I[5] = 1;
  I[10] = 1;
  I[15] = 1;
  rtb_TmpSignalConversionAtSFun_0[0] = 0.0;
  rtb_TmpSignalConversionAtSFun_0[3] = -Kalman_DW.UnitDelay1_DSTATE[2];
  rtb_TmpSignalConversionAtSFun_0[6] = Kalman_DW.UnitDelay1_DSTATE[1];
  rtb_TmpSignalConversionAtSFun_0[1] = Kalman_DW.UnitDelay1_DSTATE[2];
  rtb_TmpSignalConversionAtSFun_0[4] = 0.0;
  rtb_TmpSignalConversionAtSFun_0[7] = -Kalman_DW.UnitDelay1_DSTATE[0];
  rtb_TmpSignalConversionAtSFun_0[2] = -Kalman_DW.UnitDelay1_DSTATE[1];
  rtb_TmpSignalConversionAtSFun_0[5] = Kalman_DW.UnitDelay1_DSTATE[0];
  rtb_TmpSignalConversionAtSFun_0[8] = 0.0;
  for (i = 0; i < 3; i++) {
    tmp[i << 2] = -rtb_TmpSignalConversionAtSFun_0[3 * i];
    tmp[1 + (i << 2)] = -rtb_TmpSignalConversionAtSFun_0[3 * i + 1];
    tmp[2 + (i << 2)] = -rtb_TmpSignalConversionAtSFun_0[3 * i + 2];
  }

  tmp[12] = Kalman_DW.UnitDelay1_DSTATE[0];
  tmp[13] = Kalman_DW.UnitDelay1_DSTATE[1];
  tmp[14] = Kalman_DW.UnitDelay1_DSTATE[2];
  tmp[3] = -Kalman_DW.UnitDelay1_DSTATE[0];
  tmp[7] = -Kalman_DW.UnitDelay1_DSTATE[1];
  tmp[11] = -Kalman_DW.UnitDelay1_DSTATE[2];
  tmp[15] = 0.0;
  for (i = 0; i < 4; i++) {
    I_0[i << 2] = tmp[i << 2] * 0.5 * 0.01 + (real_T)I[i << 2];
    I_0[1 + (i << 2)] = tmp[(i << 2) + 1] * 0.5 * 0.01 + (real_T)I[(i << 2) + 1];
    I_0[2 + (i << 2)] = tmp[(i << 2) + 2] * 0.5 * 0.01 + (real_T)I[(i << 2) + 2];
    I_0[3 + (i << 2)] = tmp[(i << 2) + 3] * 0.5 * 0.01 + (real_T)I[(i << 2) + 3];
  }

  for (i = 0; i < 4; i++) {
    rtb_qkm_p = I_0[i + 12] * Kalman_DW.UnitDelay2_DSTATE[3] + (I_0[i + 8] *
      Kalman_DW.UnitDelay2_DSTATE[2] + (I_0[i + 4] *
      Kalman_DW.UnitDelay2_DSTATE[1] + I_0[i] * Kalman_DW.UnitDelay2_DSTATE[0]));
    rtb_qkm[i] = rtb_qkm_p;
  }

  /* '<S1>:1:20' */
  rtb_qkp_idx_0 = sqrt(((rtb_qkm[0] * rtb_qkm[0] + rtb_qkm[1] * rtb_qkm[1]) +
                        rtb_qkm[2] * rtb_qkm[2]) + rtb_qkm[3] * rtb_qkm[3]);
  rtb_qkm[0] /= rtb_qkp_idx_0;
  rtb_qkm[1] /= rtb_qkp_idx_0;
  rtb_qkm[2] /= rtb_qkp_idx_0;
  rtb_qkm_p = rtb_qkm[3] / rtb_qkp_idx_0;

  /* % Bias propagation */
  /* '<S1>:1:23' */
  /* % Covariance equation propagation */
  /*  omekhatx = [     0      -omehat(3)  omehat(2) ; */
  /*               omehat(3)     0       -omehat(1) ; */
  /*              -omehat(2)  omehat(1)      0     ]; */
  /*  nomehat = sqrt(omehat(1)^2+omehat(2)^2+omehat(3)^2); */
  /*  Phi1 = I3 - omekhatx*sin(nomehat*dt)/nomehat + omekhatx*omekhatx*(1 - cos(nomehat*dt))/(nomehat^2); */
  /*  Phi2 = omekhatx*(1 - cos(nomehat*dt))/(nomehat^2) - I3*dt - omekhatx*omekhatx*(nomehat*dt - sin(nomehat*dt))/(nomehat^3); */
  /* '<S1>:1:40' */
  for (i = 0; i < 6; i++) {
    for (i_1 = 0; i_1 < 6; i_1++) {
      a_0[i + 6 * i_1] = 0.0;
      for (i_0 = 0; i_0 < 6; i_0++) {
        a_0[i + 6 * i_1] += a[6 * i_0 + i] * Kalman_DW.UnitDelay_DSTATE[6 * i_1
          + i_0];
      }
    }
  }

  for (i = 0; i < 6; i++) {
    for (i_1 = 0; i_1 < 6; i_1++) {
      dq_idx_3 = 0.0;
      for (i_0 = 0; i_0 < 6; i_0++) {
        dq_idx_3 += a_0[6 * i_0 + i] * b[6 * i_1 + i_0];
      }

      rtb_Pkm[i + 6 * i_1] = y[6 * i_1 + i] + dq_idx_3;
    }
  }

  /* End of MATLAB Function: '<Root>/Propagation ' */

  /* MATLAB Function: '<Root>/Update' incorporates:
   *  Inport: '<Root>/ax'
   *  Inport: '<Root>/ay'
   *  Inport: '<Root>/az'
   *  Inport: '<Root>/gx'
   *  Inport: '<Root>/gy'
   *  Inport: '<Root>/gz'
   *  Inport: '<Root>/mx'
   *  Inport: '<Root>/my'
   *  Inport: '<Root>/mz'
   *  UnitDelay: '<Root>/Unit Delay3'
   */
  /* MATLAB Function 'Update': '<S2>:1' */
  /* % EKF - Update           % */
  /*  Author: Mattia Giurato  % */
  /*  Last review: 2016/03/15 % */
  /* %%%%%%%%%%%%%%%%%%%%%%%%%% */
  /* '<S2>:1:6' */
  /* '<S2>:1:7' */
  /* '<S2>:1:8' */
  /* '<S2>:1:9' */
  /* '<S2>:1:10' */
  /* '<S2>:1:11' */
  /* '<S2>:1:12' */
  /* '<S2>:1:13' */
  /* '<S2>:1:14' */
  /* '<S2>:1:15' */
  /* '<S2>:1:16' */
  /* '<S2>:1:17' */
  Magnetometer[0] = Kalman_U.mx;
  Magnetometer[1] = Kalman_U.my;
  Magnetometer[2] = Kalman_U.mz;

  /*  Usefull values */
  /* '<S2>:1:23' */
  /*  Normalise accelerometer measurement */
  /*  if(norm(Accelerometer) == 0), return; end % handle NaN */
  /* '<S2>:1:28' */
  rtb_qkp_idx_0 = sqrt((Kalman_U.ax * Kalman_U.ax + Kalman_U.ay * Kalman_U.ay) +
                       Kalman_U.az * Kalman_U.az);

  /*  normalise magnitude */
  /*  Normalise magnetometer measurement */
  /*  if(norm(Magnetometer) == 0), return; end % handle NaN */
  /* '<S2>:1:32' */
  dq_idx_2 = sqrt((Kalman_U.mx * Kalman_U.mx + Kalman_U.my * Kalman_U.my) +
                  Kalman_U.mz * Kalman_U.mz);

  /*  normalise magnitude */
  /* % Propagated value from previous step */
  /* '<S2>:1:35' */
  /* % Accelerometer and Magnetometer correction */
  /*  Compute attitude matrix */
  /* '<S2>:1:39' */
  rtb_TmpSignalConversionAtSFun_n[0] = rtb_qkm[0];
  rtb_TmpSignalConversionAtSFun_n[1] = rtb_qkm[1];
  rtb_TmpSignalConversionAtSFun_n[2] = rtb_qkm[2];

  /* '<S2>:1:42' */
  /* '<S2>:1:43' */
  /* '<S2>:1:46' */
  /* '<S2>:1:47' */
  dq_idx_3 = rtb_qkm_p * rtb_qkm_p - ((rtb_qkm[0] * rtb_qkm[0] + rtb_qkm[1] *
    rtb_qkm[1]) + rtb_qkm[2] * rtb_qkm[2]);
  dq_idx_0 = 2.0 * rtb_qkm_p;
  for (i = 0; i < 3; i++) {
    rtb_TmpSignalConversionAtSFun_0[i] = rtb_TmpSignalConversionAtSFun_n[i] *
      rtb_TmpSignalConversionAtSFun_n[0];
    rtb_TmpSignalConversionAtSFun_0[i + 3] = rtb_TmpSignalConversionAtSFun_n[i] *
      rtb_TmpSignalConversionAtSFun_n[1];
    rtb_TmpSignalConversionAtSFun_0[i + 6] = rtb_TmpSignalConversionAtSFun_n[i] *
      rtb_TmpSignalConversionAtSFun_n[2];
  }

  tmp_0[0] = 0.0;
  tmp_0[3] = -rtb_qkm[2];
  tmp_0[6] = rtb_qkm[1];
  tmp_0[1] = rtb_qkm[2];
  tmp_0[4] = 0.0;
  tmp_0[7] = -rtb_qkm[0];
  tmp_0[2] = -rtb_qkm[1];
  tmp_0[5] = rtb_qkm[0];
  tmp_0[8] = 0.0;
  for (i = 0; i < 3; i++) {
    Aqkm[3 * i] = ((real_T)b_b[3 * i] * dq_idx_3 +
                   rtb_TmpSignalConversionAtSFun_0[3 * i] * 2.0) - tmp_0[3 * i] *
      dq_idx_0;
    Aqkm[1 + 3 * i] = ((real_T)b_b[3 * i + 1] * dq_idx_3 +
                       rtb_TmpSignalConversionAtSFun_0[3 * i + 1] * 2.0) -
      tmp_0[3 * i + 1] * dq_idx_0;
    Aqkm[2 + 3 * i] = ((real_T)b_b[3 * i + 2] * dq_idx_3 +
                       rtb_TmpSignalConversionAtSFun_0[3 * i + 2] * 2.0) -
      tmp_0[3 * i + 2] * dq_idx_0;
  }

  /*  Reference direction of Earth's gravitational field */
  /* '<S2>:1:52' */
  for (i = 0; i < 3; i++) {
    Aqmr[i] = Aqkm[i + 6];
  }

  /* '<S2>:1:54' */
  /*  Sensitivity Matrix */
  /* '<S2>:1:57' */
  /* '<S2>:1:60' */
  Hk[0] = 0.0;
  Hk[3] = -Aqmr[2];
  Hk[6] = Aqmr[1];
  Hk[1] = Aqmr[2];
  Hk[4] = 0.0;
  Hk[7] = -Aqmr[0];
  Hk[2] = -Aqmr[1];
  Hk[5] = Aqmr[0];
  Hk[8] = 0.0;
  for (i = 0; i < 3; i++) {
    Hk[3 * (i + 3)] = 0.0;
    Hk[1 + 3 * (i + 3)] = 0.0;
    Hk[2 + 3 * (i + 3)] = 0.0;
  }

  /*  Gain */
  /* '<S2>:1:63' */
  for (i = 0; i < 6; i++) {
    for (i_1 = 0; i_1 < 3; i_1++) {
      rtb_Pkm_0[i + 6 * i_1] = 0.0;
      for (i_0 = 0; i_0 < 6; i_0++) {
        rtb_Pkm_0[i + 6 * i_1] += rtb_Pkm[6 * i_0 + i] * Hk[3 * i_0 + i_1];
      }
    }
  }

  for (i = 0; i < 3; i++) {
    for (i_1 = 0; i_1 < 6; i_1++) {
      Kk[i + 3 * i_1] = 0.0;
      for (i_0 = 0; i_0 < 6; i_0++) {
        Kk[i + 3 * i_1] += Hk[3 * i_0 + i] * rtb_Pkm[6 * i_1 + i_0];
      }
    }
  }

  for (i = 0; i < 3; i++) {
    for (i_1 = 0; i_1 < 3; i_1++) {
      dq_idx_3 = 0.0;
      for (i_0 = 0; i_0 < 6; i_0++) {
        dq_idx_3 += Kk[3 * i_0 + i] * Hk[3 * i_0 + i_1];
      }

      rtb_TmpSignalConversionAtSFun_0[i + 3 * i_1] = b_R[3 * i_1 + i] + dq_idx_3;
    }
  }

  Kalman_mrdivide(rtb_Pkm_0, rtb_TmpSignalConversionAtSFun_0, Kk);

  /*  Update Covariance */
  /* '<S2>:1:66' */
  for (i = 0; i < 6; i++) {
    for (i_1 = 0; i_1 < 6; i_1++) {
      a_0[i + 6 * i_1] = (real_T)I6[6 * i_1 + i] - ((Hk[3 * i_1 + 1] * Kk[i + 6]
        + Hk[3 * i_1] * Kk[i]) + Hk[3 * i_1 + 2] * Kk[i + 12]);
    }
  }

  for (i = 0; i < 6; i++) {
    for (i_1 = 0; i_1 < 6; i_1++) {
      I6_0[i + 6 * i_1] = 0.0;
      for (i_0 = 0; i_0 < 6; i_0++) {
        I6_0[i + 6 * i_1] += a_0[6 * i_0 + i] * rtb_Pkm[6 * i_1 + i_0];
      }
    }
  }

  for (i = 0; i < 6; i++) {
    for (i_1 = 0; i_1 < 6; i_1++) {
      a_0[i + 6 * i_1] = (real_T)I6[6 * i + i_1] - ((Hk[3 * i + 1] * Kk[i_1 + 6]
        + Hk[3 * i] * Kk[i_1]) + Hk[3 * i + 2] * Kk[i_1 + 12]);
    }
  }

  for (i = 0; i < 6; i++) {
    for (i_1 = 0; i_1 < 3; i_1++) {
      rtb_Pkm_0[i + 6 * i_1] = 0.0;
      rtb_Pkm_0[i + 6 * i_1] += b_R[3 * i_1] * Kk[i];
      rtb_Pkm_0[i + 6 * i_1] += b_R[3 * i_1 + 1] * Kk[i + 6];
      rtb_Pkm_0[i + 6 * i_1] += b_R[3 * i_1 + 2] * Kk[i + 12];
    }
  }

  for (i = 0; i < 6; i++) {
    for (i_1 = 0; i_1 < 6; i_1++) {
      rtb_Pkm[i + 6 * i_1] = 0.0;
      for (i_0 = 0; i_0 < 6; i_0++) {
        rtb_Pkm[i + 6 * i_1] += I6_0[6 * i_0 + i] * a_0[6 * i_1 + i_0];
      }
    }
  }

  for (i = 0; i < 6; i++) {
    for (i_1 = 0; i_1 < 6; i_1++) {
      a_0[i + 6 * i_1] = 0.0;
      a_0[i + 6 * i_1] += rtb_Pkm_0[i] * Kk[i_1];
      a_0[i + 6 * i_1] += rtb_Pkm_0[i + 6] * Kk[i_1 + 6];
      a_0[i + 6 * i_1] += rtb_Pkm_0[i + 12] * Kk[i_1 + 12];
    }
  }

  for (i = 0; i < 6; i++) {
    for (i_1 = 0; i_1 < 6; i_1++) {
      Pkp[i_1 + 6 * i] = rtb_Pkm[6 * i + i_1] + a_0[6 * i + i_1];
    }
  }

  /*  Update state */
  /* '<S2>:1:69' */
  /* residual */
  /* '<S2>:1:70' */
  /* '<S2>:1:71' */
  dq_idx_0 = Kalman_U.ax / rtb_qkp_idx_0 - Aqmr[0];
  dq_idx_1 = Kalman_U.ay / rtb_qkp_idx_0 - Aqmr[1];
  dq_idx_3 = Kalman_U.az / rtb_qkp_idx_0 - Aqmr[2];
  for (i = 0; i < 6; i++) {
    deltaXkp[i] = (Kk[i + 6] * dq_idx_1 + Kk[i] * dq_idx_0) + Kk[i + 12] *
      dq_idx_3;
  }

  /*  Reference direction of Earth's magnetic feild */
  /* '<S2>:1:77' */
  for (i = 0; i < 3; i++) {
    rtb_TmpSignalConversionAtSFun_l[i] = Aqkm[i + 6] * Kalman_U.mz + (Aqkm[i + 3]
      * Kalman_U.my + Aqkm[i] * Kalman_U.mx);
  }

  /* '<S2>:1:78' */
  /* '<S2>:1:79' */
  /* '<S2>:1:82' */
  dq_idx_3 = sqrt(rtb_TmpSignalConversionAtSFun_l[0] *
                  rtb_TmpSignalConversionAtSFun_l[0] +
                  rtb_TmpSignalConversionAtSFun_l[1] *
                  rtb_TmpSignalConversionAtSFun_l[1]);
  for (i = 0; i < 3; i++) {
    Aqmr[i] = Aqkm[i + 6] * rtb_TmpSignalConversionAtSFun_l[2] + Aqkm[i] *
      dq_idx_3;
  }

  /* '<S2>:1:84' */
  /*  Sensitivity Matrix */
  /* '<S2>:1:87' */
  /* '<S2>:1:90' */
  Hk[0] = 0.0;
  Hk[3] = -Aqmr[2];
  Hk[6] = Aqmr[1];
  Hk[1] = Aqmr[2];
  Hk[4] = 0.0;
  Hk[7] = -Aqmr[0];
  Hk[2] = -Aqmr[1];
  Hk[5] = Aqmr[0];
  Hk[8] = 0.0;
  for (i = 0; i < 3; i++) {
    Hk[3 * (i + 3)] = 0.0;
    Hk[1 + 3 * (i + 3)] = 0.0;
    Hk[2 + 3 * (i + 3)] = 0.0;
  }

  /*  Gain */
  /* '<S2>:1:93' */
  for (i = 0; i < 6; i++) {
    for (i_1 = 0; i_1 < 3; i_1++) {
      rtb_Pkm_0[i + 6 * i_1] = 0.0;
      for (i_0 = 0; i_0 < 6; i_0++) {
        rtb_Pkm_0[i + 6 * i_1] += Pkp[6 * i_0 + i] * Hk[3 * i_0 + i_1];
      }
    }
  }

  for (i = 0; i < 3; i++) {
    for (i_1 = 0; i_1 < 6; i_1++) {
      Kk[i + 3 * i_1] = 0.0;
      for (i_0 = 0; i_0 < 6; i_0++) {
        Kk[i + 3 * i_1] += Hk[3 * i_0 + i] * Pkp[6 * i_1 + i_0];
      }
    }
  }

  for (i = 0; i < 3; i++) {
    for (i_1 = 0; i_1 < 3; i_1++) {
      dq_idx_3 = 0.0;
      for (i_0 = 0; i_0 < 6; i_0++) {
        dq_idx_3 += Kk[3 * i_0 + i] * Hk[3 * i_0 + i_1];
      }

      rtb_TmpSignalConversionAtSFun_0[i + 3 * i_1] = R[3 * i_1 + i] + dq_idx_3;
    }
  }

  Kalman_mrdivide(rtb_Pkm_0, rtb_TmpSignalConversionAtSFun_0, Kk);

  /*  Update Covariance */
  /* '<S2>:1:96' */
  /*  Update state */
  /* '<S2>:1:99' */
  /* residual */
  /* '<S2>:1:100' */
  /* '<S2>:1:101' */
  for (i = 0; i < 3; i++) {
    dq_idx_3 = 0.0;
    for (i_1 = 0; i_1 < 6; i_1++) {
      dq_idx_3 += Hk[3 * i_1 + i] * deltaXkp[i_1];
    }

    Magnetometer_0[i] = (Magnetometer[i] / dq_idx_2 - Aqmr[i]) - dq_idx_3;
  }

  for (i = 0; i < 6; i++) {
    deltaXkp[i] += (Kk[i + 6] * Magnetometer_0[1] + Kk[i] * Magnetometer_0[0]) +
      Kk[i + 12] * Magnetometer_0[2];
  }

  /*  Update quaternion */
  /* '<S2>:1:104' */
  /* '<S2>:1:105' */
  /* '<S2>:1:106' */
  rtb_qkp_idx_0 = 1.0 / sqrt(((deltaXkp[0] * deltaXkp[0] + deltaXkp[1] *
    deltaXkp[1]) + deltaXkp[2] * deltaXkp[2]) + 4.0);
  dq_idx_0 = rtb_qkp_idx_0 * deltaXkp[0];
  dq_idx_1 = rtb_qkp_idx_0 * deltaXkp[1];
  dq_idx_2 = rtb_qkp_idx_0 * deltaXkp[2];
  dq_idx_3 = rtb_qkp_idx_0 * 2.0;

  /* '<S2>:1:107' */
  rtb_qkp_idx_0 = (dq_idx_3 * rtb_qkm[0] + rtb_qkm_p * dq_idx_0) - (dq_idx_1 *
    rtb_qkm[2] - dq_idx_2 * rtb_qkm[1]);
  rtb_qkp_idx_1 = (dq_idx_3 * rtb_qkm[1] + rtb_qkm_p * dq_idx_1) - (dq_idx_2 *
    rtb_qkm[0] - dq_idx_0 * rtb_qkm[2]);
  rtb_qkp_idx_2 = (dq_idx_3 * rtb_qkm[2] + rtb_qkm_p * dq_idx_2) - (dq_idx_0 *
    rtb_qkm[1] - dq_idx_1 * rtb_qkm[0]);
  dq_idx_3 = dq_idx_3 * rtb_qkm_p - ((dq_idx_0 * rtb_qkm[0] + dq_idx_1 *
    rtb_qkm[1]) + dq_idx_2 * rtb_qkm[2]);

  /*  Update biases */
  /* '<S2>:1:111' */
  /* '<S2>:1:112' */
  rtb_TmpSignalConversionAtSFun_n[0] = Kalman_DW.UnitDelay3_DSTATE[0] +
    deltaXkp[3];
  rtb_TmpSignalConversionAtSFun_n[1] = Kalman_DW.UnitDelay3_DSTATE[1] +
    deltaXkp[4];
  rtb_TmpSignalConversionAtSFun_n[2] = Kalman_DW.UnitDelay3_DSTATE[2] +
    deltaXkp[5];

  /* % Depolarize gyroscope measurement */
  /* '<S2>:1:115' */
  /* % Convert Quaternion into RPY */
  /* '<S2>:1:118' */
  /* '<S2>:1:119' */
  /* '<S2>:1:120' */
  /* '<S2>:1:121' */
  /* '<S2>:1:122' */
  /* '<S2>:1:124' */
  /* '<S2>:1:125' */
  /* '<S2>:1:126' */
  /* '<S2>:1:128' */
  rtb_TmpSignalConversionAtSFun_l[0] = Kalman_U.gx -
    rtb_TmpSignalConversionAtSFun_n[0];
  rtb_TmpSignalConversionAtSFun_l[1] = Kalman_U.gy -
    rtb_TmpSignalConversionAtSFun_n[1];
  rtb_TmpSignalConversionAtSFun_l[2] = Kalman_U.gz -
    rtb_TmpSignalConversionAtSFun_n[2];

  /* Outport: '<Root>/Quaternion' */
  Kalman_Y.Quaternion[0] = rtb_qkp_idx_0;
  Kalman_Y.Quaternion[1] = rtb_qkp_idx_1;
  Kalman_Y.Quaternion[2] = rtb_qkp_idx_2;
  Kalman_Y.Quaternion[3] = dq_idx_3;

  /* Outport: '<Root>/OmegaHat' */
  Kalman_Y.OmegaHat[0] = rtb_TmpSignalConversionAtSFun_l[0];
  Kalman_Y.OmegaHat[1] = rtb_TmpSignalConversionAtSFun_l[1];
  Kalman_Y.OmegaHat[2] = rtb_TmpSignalConversionAtSFun_l[2];

  /* Outport: '<Root>/RPY' incorporates:
   *  MATLAB Function: '<Root>/Update'
   */
  Kalman_Y.RPY[0] = atan2((rtb_qkp_idx_1 * rtb_qkp_idx_2 + dq_idx_3 *
    rtb_qkp_idx_0) * 2.0, ((dq_idx_3 * dq_idx_3 - rtb_qkp_idx_0 * rtb_qkp_idx_0)
    - rtb_qkp_idx_1 * rtb_qkp_idx_1) + rtb_qkp_idx_2 * rtb_qkp_idx_2);
  Kalman_Y.RPY[1] = -asin((rtb_qkp_idx_0 * rtb_qkp_idx_2 - dq_idx_3 *
    rtb_qkp_idx_1) * -2.0);
  Kalman_Y.RPY[2] = -atan2((rtb_qkp_idx_0 * rtb_qkp_idx_1 + dq_idx_3 *
    rtb_qkp_idx_2) * 2.0, ((dq_idx_3 * dq_idx_3 + rtb_qkp_idx_0 * rtb_qkp_idx_0)
    - rtb_qkp_idx_1 * rtb_qkp_idx_1) - rtb_qkp_idx_2 * rtb_qkp_idx_2);

  /* Outport: '<Root>/beta ' */
  Kalman_Y.beta[0] = rtb_TmpSignalConversionAtSFun_n[0];
  Kalman_Y.beta[1] = rtb_TmpSignalConversionAtSFun_n[1];
  Kalman_Y.beta[2] = rtb_TmpSignalConversionAtSFun_n[2];

  /* MATLAB Function: '<Root>/Update' */
  for (i = 0; i < 6; i++) {
    for (i_1 = 0; i_1 < 6; i_1++) {
      a_0[i + 6 * i_1] = (real_T)I6[6 * i_1 + i] - ((Hk[3 * i_1 + 1] * Kk[i + 6]
        + Hk[3 * i_1] * Kk[i]) + Hk[3 * i_1 + 2] * Kk[i + 12]);
    }
  }

  for (i = 0; i < 6; i++) {
    for (i_1 = 0; i_1 < 6; i_1++) {
      I6_0[i + 6 * i_1] = 0.0;
      for (i_0 = 0; i_0 < 6; i_0++) {
        I6_0[i + 6 * i_1] += a_0[6 * i_0 + i] * Pkp[6 * i_1 + i_0];
      }
    }
  }

  for (i = 0; i < 6; i++) {
    for (i_1 = 0; i_1 < 6; i_1++) {
      a_0[i + 6 * i_1] = (real_T)I6[6 * i + i_1] - ((Hk[3 * i + 1] * Kk[i_1 + 6]
        + Hk[3 * i] * Kk[i_1]) + Hk[3 * i + 2] * Kk[i_1 + 12]);
    }
  }

  for (i = 0; i < 6; i++) {
    for (i_1 = 0; i_1 < 3; i_1++) {
      rtb_Pkm_0[i + 6 * i_1] = 0.0;
      rtb_Pkm_0[i + 6 * i_1] += R[3 * i_1] * Kk[i];
      rtb_Pkm_0[i + 6 * i_1] += R[3 * i_1 + 1] * Kk[i + 6];
      rtb_Pkm_0[i + 6 * i_1] += R[3 * i_1 + 2] * Kk[i + 12];
    }
  }

  for (i = 0; i < 6; i++) {
    for (i_1 = 0; i_1 < 6; i_1++) {
      rtb_Pkm[i + 6 * i_1] = 0.0;
      for (i_0 = 0; i_0 < 6; i_0++) {
        rtb_Pkm[i + 6 * i_1] += I6_0[6 * i_0 + i] * a_0[6 * i_1 + i_0];
      }
    }
  }

  for (i = 0; i < 6; i++) {
    for (i_1 = 0; i_1 < 6; i_1++) {
      a_0[i + 6 * i_1] = 0.0;
      a_0[i + 6 * i_1] += rtb_Pkm_0[i] * Kk[i_1];
      a_0[i + 6 * i_1] += rtb_Pkm_0[i + 6] * Kk[i_1 + 6];
      a_0[i + 6 * i_1] += rtb_Pkm_0[i + 12] * Kk[i_1 + 12];
    }
  }

  /* Update for UnitDelay: '<Root>/Unit Delay' incorporates:
   *  MATLAB Function: '<Root>/Update'
   */
  for (i = 0; i < 6; i++) {
    for (i_1 = 0; i_1 < 6; i_1++) {
      Kalman_DW.UnitDelay_DSTATE[i_1 + 6 * i] = rtb_Pkm[6 * i + i_1] + a_0[6 * i
        + i_1];
    }
  }

  /* End of Update for UnitDelay: '<Root>/Unit Delay' */

  /* Update for UnitDelay: '<Root>/Unit Delay2' */
  Kalman_DW.UnitDelay2_DSTATE[0] = rtb_qkp_idx_0;
  Kalman_DW.UnitDelay2_DSTATE[1] = rtb_qkp_idx_1;
  Kalman_DW.UnitDelay2_DSTATE[2] = rtb_qkp_idx_2;
  Kalman_DW.UnitDelay2_DSTATE[3] = dq_idx_3;

  /* Update for UnitDelay: '<Root>/Unit Delay1' */
  Kalman_DW.UnitDelay1_DSTATE[0] = rtb_TmpSignalConversionAtSFun_l[0];
  Kalman_DW.UnitDelay1_DSTATE[1] = rtb_TmpSignalConversionAtSFun_l[1];
  Kalman_DW.UnitDelay1_DSTATE[2] = rtb_TmpSignalConversionAtSFun_l[2];

  /* Update for UnitDelay: '<Root>/Unit Delay3' */
  Kalman_DW.UnitDelay3_DSTATE[0] = rtb_TmpSignalConversionAtSFun_n[0];
  Kalman_DW.UnitDelay3_DSTATE[1] = rtb_TmpSignalConversionAtSFun_n[1];
  Kalman_DW.UnitDelay3_DSTATE[2] = rtb_TmpSignalConversionAtSFun_n[2];
}

/* Model initialize function */
void KalmanModelClass::initialize()
{
  /* Registration code */

  /* initialize error status */
  rtmSetErrorStatus((&Kalman_M), (NULL));

  /* states (dwork) */
  (void) memset((void *)&Kalman_DW, 0,
                sizeof(DW_Kalman_T));

  /* external inputs */
  (void) memset((void *)&Kalman_U, 0,
                sizeof(ExtU_Kalman_T));

  /* external outputs */
  (void) memset((void *)&Kalman_Y, 0,
                sizeof(ExtY_Kalman_T));

  /* InitializeConditions for UnitDelay: '<Root>/Unit Delay' */
  memcpy(&Kalman_DW.UnitDelay_DSTATE[0], &Kalman_P.UnitDelay_InitialCondition[0],
         36U * sizeof(real_T));

  /* InitializeConditions for UnitDelay: '<Root>/Unit Delay2' */
  Kalman_DW.UnitDelay2_DSTATE[0] = Kalman_P.UnitDelay2_InitialCondition[0];
  Kalman_DW.UnitDelay2_DSTATE[1] = Kalman_P.UnitDelay2_InitialCondition[1];
  Kalman_DW.UnitDelay2_DSTATE[2] = Kalman_P.UnitDelay2_InitialCondition[2];
  Kalman_DW.UnitDelay2_DSTATE[3] = Kalman_P.UnitDelay2_InitialCondition[3];

  /* InitializeConditions for UnitDelay: '<Root>/Unit Delay1' */
  Kalman_DW.UnitDelay1_DSTATE[0] = Kalman_P.UnitDelay1_InitialCondition[0];
  Kalman_DW.UnitDelay1_DSTATE[1] = Kalman_P.UnitDelay1_InitialCondition[1];
  Kalman_DW.UnitDelay1_DSTATE[2] = Kalman_P.UnitDelay1_InitialCondition[2];

  /* InitializeConditions for UnitDelay: '<Root>/Unit Delay3' */
  Kalman_DW.UnitDelay3_DSTATE[0] = Kalman_P.UnitDelay3_InitialCondition[0];
  Kalman_DW.UnitDelay3_DSTATE[1] = Kalman_P.UnitDelay3_InitialCondition[1];
  Kalman_DW.UnitDelay3_DSTATE[2] = Kalman_P.UnitDelay3_InitialCondition[2];
}

/* Model terminate function */
void KalmanModelClass::terminate()
{
  /* (no terminate code required) */
}

/* Constructor */
KalmanModelClass::KalmanModelClass()
{
  static const P_Kalman_T Kalman_P_temp = {
    /*  Expression: (1e-6)*[1 0 0 0 0 0; 0 1 0 0 0 0; 0 0 1 0 0 0; 0 0 0 1 0 0; 0 0 0 0 1 0; 0 0 0 0 0 1]
     * Referenced by: '<Root>/Unit Delay'
     */
    { 1.0E-6, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0E-6, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
      1.0E-6, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0E-6, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
      1.0E-6, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0E-6 },

    /*  Expression: [0 0 0 1]'
     * Referenced by: '<Root>/Unit Delay2'
     */
    { 0.0, 0.0, 0.0, 1.0 },

    /*  Expression: 0.00001*[1 1 1]'
     * Referenced by: '<Root>/Unit Delay1'
     */
    { 1.0E-5, 1.0E-5, 1.0E-5 },

    /*  Expression: 0.00001*[1 1 1]'
     * Referenced by: '<Root>/Unit Delay3'
     */
    { 1.0E-5, 1.0E-5, 1.0E-5 }
  };                                   /* Modifiable parameters */

  /* Initialize tunable parameters */
  Kalman_P = Kalman_P_temp;
}

/* Destructor */
KalmanModelClass::~KalmanModelClass()
{
  /* Currently there is no destructor body generated.*/
}

/* Real-Time Model get method */
RT_MODEL_Kalman_T * KalmanModelClass::getRTM()
{
  return (&Kalman_M);
}

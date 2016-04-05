clc
close all

%% Extract values
time = RPY.time;
clear tout

R = RPY.signals.values(:,1);
P = RPY.signals.values(:,2);
Y = RPY.signals.values(:,3);
clear RPY

p = Omega.signals.values(:,1);
q = Omega.signals.values(:,2);
r = Omega.signals.values(:,3);
clear Omega

beta_p = beta.signals.values(:,1);
beta_q = beta.signals.values(:,2);
beta_r = beta.signals.values(:,3);
clear beta

q_1 = Quaternion.signals.values(:,1);
q_2 = Quaternion.signals.values(:,2);
q_3 = Quaternion.signals.values(:,3);
q_4 = Quaternion.signals.values(:,4);
clear Quaternion

% Kkacc11 = reshape(Kkacc.signals.values(1,1,:),[length(Kkacc.signals.values(1,1,:)) 1]);
% Kkacc12 = reshape(Kkacc.signals.values(1,2,:),[length(Kkacc.signals.values(1,1,:)) 1]);
% Kkacc13 = reshape(Kkacc.signals.values(1,3,:),[length(Kkacc.signals.values(1,1,:)) 1]);
% Kkacc21 = reshape(Kkacc.signals.values(2,1,:),[length(Kkacc.signals.values(1,1,:)) 1]);
% Kkacc22 = reshape(Kkacc.signals.values(2,2,:),[length(Kkacc.signals.values(1,1,:)) 1]);
% Kkacc23 = reshape(Kkacc.signals.values(2,3,:),[length(Kkacc.signals.values(1,1,:)) 1]);
% Kkacc31 = reshape(Kkacc.signals.values(3,1,:),[length(Kkacc.signals.values(1,1,:)) 1]);
% Kkacc32 = reshape(Kkacc.signals.values(3,2,:),[length(Kkacc.signals.values(1,1,:)) 1]);
% Kkacc33 = reshape(Kkacc.signals.values(3,3,:),[length(Kkacc.signals.values(1,1,:)) 1]);
% Kkacc41 = reshape(Kkacc.signals.values(4,1,:),[length(Kkacc.signals.values(1,1,:)) 1]);
% Kkacc42 = reshape(Kkacc.signals.values(4,2,:),[length(Kkacc.signals.values(1,1,:)) 1]);
% Kkacc43 = reshape(Kkacc.signals.values(4,3,:),[length(Kkacc.signals.values(1,1,:)) 1]);
% Kkacc51 = reshape(Kkacc.signals.values(5,1,:),[length(Kkacc.signals.values(1,1,:)) 1]);
% Kkacc52 = reshape(Kkacc.signals.values(5,2,:),[length(Kkacc.signals.values(1,1,:)) 1]);
% Kkacc53 = reshape(Kkacc.signals.values(5,3,:),[length(Kkacc.signals.values(1,1,:)) 1]);
% Kkacc61 = reshape(Kkacc.signals.values(6,1,:),[length(Kkacc.signals.values(1,1,:)) 1]);
% Kkacc62 = reshape(Kkacc.signals.values(6,2,:),[length(Kkacc.signals.values(1,1,:)) 1]);
% Kkacc63 = reshape(Kkacc.signals.values(6,3,:),[length(Kkacc.signals.values(1,1,:)) 1]);
% % clear Kkacc
% 
% Kkmag11 = reshape(Kkmag.signals.values(1,1,:),[length(Kkmag.signals.values(1,1,:)) 1]);
% Kkmag12 = reshape(Kkmag.signals.values(1,2,:),[length(Kkmag.signals.values(1,1,:)) 1]);
% Kkmag13 = reshape(Kkmag.signals.values(1,3,:),[length(Kkmag.signals.values(1,1,:)) 1]);
% Kkmag21 = reshape(Kkmag.signals.values(2,1,:),[length(Kkmag.signals.values(1,1,:)) 1]);
% Kkmag22 = reshape(Kkmag.signals.values(2,2,:),[length(Kkmag.signals.values(1,1,:)) 1]);
% Kkmag23 = reshape(Kkmag.signals.values(2,3,:),[length(Kkmag.signals.values(1,1,:)) 1]);
% Kkmag31 = reshape(Kkmag.signals.values(3,1,:),[length(Kkmag.signals.values(1,1,:)) 1]);
% Kkmag32 = reshape(Kkmag.signals.values(3,2,:),[length(Kkmag.signals.values(1,1,:)) 1]);
% Kkmag33 = reshape(Kkmag.signals.values(3,3,:),[length(Kkmag.signals.values(1,1,:)) 1]);
% Kkmag41 = reshape(Kkmag.signals.values(4,1,:),[length(Kkmag.signals.values(1,1,:)) 1]);
% Kkmag42 = reshape(Kkmag.signals.values(4,2,:),[length(Kkmag.signals.values(1,1,:)) 1]);
% Kkmag43 = reshape(Kkmag.signals.values(4,3,:),[length(Kkmag.signals.values(1,1,:)) 1]);
% Kkmag51 = reshape(Kkmag.signals.values(5,1,:),[length(Kkmag.signals.values(1,1,:)) 1]);
% Kkmag52 = reshape(Kkmag.signals.values(5,2,:),[length(Kkmag.signals.values(1,1,:)) 1]);
% Kkmag53 = reshape(Kkmag.signals.values(5,3,:),[length(Kkmag.signals.values(1,1,:)) 1]);
% Kkmag61 = reshape(Kkmag.signals.values(6,1,:),[length(Kkmag.signals.values(1,1,:)) 1]);
% Kkmag62 = reshape(Kkmag.signals.values(6,2,:),[length(Kkmag.signals.values(1,1,:)) 1]);
% Kkmag63 = reshape(Kkmag.signals.values(6,3,:),[length(Kkmag.signals.values(1,1,:)) 1]);
% % clear Kkmag

%% Plot results

figure
subplot(3,1,1)
plot(time,R)
subplot(3,1,2)
plot(time,P)
subplot(3,1,3)
plot(time,Y)

figure
subplot(3,1,1)
plot(time,p)
subplot(3,1,2)
plot(time,q)
subplot(3,1,3)
plot(time,r)

% figure('name','Kacc')
% subplot(6,3,1)
% plot(time,Kkacc11)
% subplot(6,3,2)
% plot(time,Kkacc12)
% subplot(6,3,3)
% plot(time,Kkacc13)
% subplot(6,3,4)
% plot(time,Kkacc21)
% subplot(6,3,5)
% plot(time,Kkacc22)
% subplot(6,3,6)
% plot(time,Kkacc23)
% subplot(6,3,7)
% plot(time,Kkacc31)
% subplot(6,3,8)
% plot(time,Kkacc32)
% subplot(6,3,9)
% plot(time,Kkacc33)
% subplot(6,3,10)
% plot(time,Kkacc41)
% subplot(6,3,11)
% plot(time,Kkacc42)
% subplot(6,3,12)
% plot(time,Kkacc43)
% subplot(6,3,13)
% plot(time,Kkacc51)
% subplot(6,3,14)
% plot(time,Kkacc52)
% subplot(6,3,15)
% plot(time,Kkacc53)
% subplot(6,3,16)
% plot(time,Kkacc61)
% subplot(6,3,17)
% plot(time,Kkacc62)
% subplot(6,3,18)
% plot(time,Kkacc63)
% 
% figure('name','Kmag')
% subplot(6,3,1)
% plot(time,Kkmag11)
% subplot(6,3,2)
% plot(time,Kkmag12)
% subplot(6,3,3)
% plot(time,Kkmag13)
% subplot(6,3,4)
% plot(time,Kkmag21)
% subplot(6,3,5)
% plot(time,Kkmag22)
% subplot(6,3,6)
% plot(time,Kkmag23)
% subplot(6,3,7)
% plot(time,Kkmag31)
% subplot(6,3,8)
% plot(time,Kkmag32)
% subplot(6,3,9)
% plot(time,Kkmag33)
% subplot(6,3,10)
% plot(time,Kkmag41)
% subplot(6,3,11)
% plot(time,Kkmag42)
% subplot(6,3,12)
% plot(time,Kkmag43)
% subplot(6,3,13)
% plot(time,Kkmag51)
% subplot(6,3,14)
% plot(time,Kkmag52)
% subplot(6,3,15)
% plot(time,Kkmag53)
% subplot(6,3,16)
% plot(time,Kkmag61)
% subplot(6,3,17)
% plot(time,Kkmag62)
% subplot(6,3,18)
% plot(time,Kkmag63)

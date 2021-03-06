function [SolidFuelLeft,LiquidFuelUsed,mass,TotalExtTank] = Weight(c, LiquidFuelUsed,Throttle, jettison,t)
% [SolidFuelLeft,LiquidFuelUsed,mass,TotalExtTank] = Weight(FullExtTank,weightOrbiter,SolidFuelLeft,LiquidFuelUsed,weightEmptyBooster)
% finds total weight and mass of space shuttle, taking into account the
% weight of the fuel that is being used
%
% returns four variables, the solid fuel left, the liquid fuel the mass and the weight of the ext tank
% v 5.0

weightOrbiter = 217513; %lbs of the bit the astronauts are in
SolidFuelLeft = jettison*(c.weightSolidFuel-t*c.SolidFuelpS); %solid fuel used per second is constant

LiquidFuelUsed = LiquidFuelUsed + 3*0.99*(0.5+0.5*Throttle)*c.timestep*c.LFuelpS; %Liquid fuel used per second is based on the throttle value
%0.99 is because the fuel goes into negative numbers otherwise (and because I'm a hack)
lb2slug = 0.031081;
TotalExtTank = c.FullExtTank - LiquidFuelUsed; %weight of the ext tank at the present time

%the total weight at any time is the weight of all the tanks, all the fuel and the orbiter minus the fuel used so far
TotalWeight = (TotalExtTank+weightOrbiter+SolidFuelLeft+c.weightEmptyBooster*jettison);
mass = TotalWeight*lb2slug; %mass in slugs


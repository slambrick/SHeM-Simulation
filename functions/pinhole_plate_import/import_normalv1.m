% import_annular.m
%
% Copyright (c) 2018-21, Sam Lambrick.
% All rights reserved.
% This file is part of the SHeM Ray Tracing Simulation, subject to the 
% GNU/GPL-3.0-or-later.
%
% Imports the crude annular pinholeplate model
%
% Calling syntax:
%  pinhole_surface = import_annular();
%
% OUPUT:
%  pinhole_surface - TriagSurface object containing the triangulation of the
%                     pinhole plate.
function pinhole_surface = import_normalv1()
    plate_fname = 'pinholePlates/Pinhole_90_PinholePlate 2019_3mmDiscAperture_forSimulation.stl';
    
    data = load('objects/defMaterial.mat');
    defMaterial = data.defMaterial;
    materials = containers.Map({'default'}, {defMaterial});
    
    % Import data from file.
    [F, V, N] = stlread(plate_fname);
    fmat = cell(length(F), 1);
    fmat(:) = {'default'};
    
    % Put inot a TiagSurface object
    flattice = zeros(size(V, 1), 6);
    pinhole_surface = TriagSurface(V, F, N, flattice, fmat, materials);
    
    % Align the plate to match the simulation
    pinhole_surface.moveBy([-5.2620, 19.1213, -25]);
end


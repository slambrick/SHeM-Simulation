function mexCompile(recompile, library)
    if nargin == 0
        recompile = true;
    elseif nargin == 1
        library = 'none';
    elseif nargin == 2
        recompile = false;
    end
    
    % Create a directory for the compiled mex binaries
    if ~exist('bin', 'dir')
        mkdir('bin')
    end
    
    % Compile the main 3D ray tracing library
    if ~exist('atom_ray_tracing_library/atom_ray_tracing3D.o', 'file') || recompile || strcmp(library, 'atom3D')
        mex -c -R2018a CFLAGS='$CFLAGS -std=c99 -Imtwister -Iatom_ray_tracing_library -Wall -pedantic -Wextra -O3   ' ...
            -outdir atom_ray_tracing_library ...
            atom_ray_tracing_library/atom_ray_tracing3D.c
    end
    
    % Compile the 2D ray tracing library
    if (~exist('atom_ray_tracing_library/atom_ray_tracing2D.o', 'file') || recompile || strcmp(library, 'atom2D')) && false
        mex -c -R2018a CFLAGS='$CFLAGS -std=c99 -Imtwister -Iatom_ray_tracing_library -Wall -pedantic -Wextra -O3   ' ...
            -outdir atom_ray_tracing_library ...
            atom_ray_tracing_library/atom_ray_tracing2D.c
    end
    
    % Compile the mtwister library
    if ~exist('mtwister/mtwister.o', 'file') || recompile || strcmp(library, 'mtwister')
        mex -c -R2018a CFLAGS='$CFLAGS -std=c99 -Imtwister -Iatom_ray_tracing_library -Wall -pedantic -Wextra -O3   ' ...
            -outdir mtwister ...
            mtwister/mtwister.c
    end
    
    % For stl pinhole plate and sample
    %mex -R2018a CFLAGS='$CFLAGS -I mtwister -I atom_ray_tracing_library -Wall -pedantic  ' ...
    %    mexFiles/tracingMex.c ...
    %    mexFiles/extract_inputs.c ...
    %    atom_ray_tracing_library/atom_ray_tracing3D.o ...
    %    mtwister/mtwister.o
    %mex -R2018a CFLAGS='$CFLAGS -I mtwister -I atom_ray_tracing_library -Wall -pedantic  ' ...
    %    mexFiles/tracingGenMex.c ...
    %    mexFiles/extract_inputs.c ...
    %    atom_ray_tracing_library/atom_ray_tracing3D.o ...
    %    mtwister/mtwister.o

    % For a simple model of the pinhole plate
    if ~exist('bin/tracingMultiMex.mexa64', 'file') || recompile
        mex -R2018a CFLAGS='$CFLAGS -std=c99 -I mtwister -I atom_ray_tracing_library -Wall -pedantic -Wextra -O3   ' ...
            -outdir bin ...
            mexFiles/tracingMultiMex.c ...
            mexFiles/extract_inputs.c ...
            atom_ray_tracing_library/atom_ray_tracing3D.o ...
            mtwister/mtwister.o
    end
    if ~exist('bin/tracingMultiGenMex.mexa64', 'file') || recompile
        mex -R2018a CFLAGS='$CFLAGS -std=c99 -I mtwister -I atom_ray_tracing_library -Wall -pedantic -Wextra -O3   ' ...
            -outdir bin ...
            mexFiles/tracingMultiGenMex.c ...
            mexFiles/extract_inputs.c ...
            atom_ray_tracing_library/atom_ray_tracing3D.o ...
            mtwister/mtwister.o
    end
    
    % For distribution or trace scattering just off a sample
    if ~exist('bin/distributionCalcMex.mexa64', 'file') || recompile
        mex -R2018a CFLAGS='$CFLAGS -std=c99 -I mtwister -I atom_ray_tracing_library -Wall -pedantic -Wextra -O3   ' ...
            -outdir bin ...
            mexFiles/distributionCalcMex.c ...
            mexFiles/extract_inputs.c ...
            atom_ray_tracing_library/atom_ray_tracing3D.o ...
            mtwister/mtwister.o
    end
    
    % For 2D scattering calculations
    if (~exist('bin/scatterRaysMex2D.mexa64', 'file') || recompile) && false
        mex -R2018a CFLAGS='$CFLAGS -std=c99 -I mtwister -I atom_ray_tracing_library -Wall -pedantic -Wextra -O3   ' ...
            -outdir bin ...
            mexFiles/scatterRaysMex2D.c ...
            atom_ray_tracing_library/atom_ray_tracing2D.o ...
            mtwister/mtwister.o
    end
    
    % For testing scattering distributions
    if ~exist('bin/distributionTestMex.mexa64', 'file') || recompile
        mex -R2018a CFLAGS='$CFLAGS -std=c99 -I mtwister -I atom_ray_tracing_library -Wall -pedantic -Wextra -O3   ' ...
            -outdir bin ...
            mexFiles/distributionTestMex.c ...
            mexFiles/extract_inputs.c ...
            atom_ray_tracing_library/atom_ray_tracing3D.o ...
            mtwister/mtwister.o
    end
    
    % A binning function I wrote.
    if ~exist('bin/binMyWayMex.mexa64') || recompile
        mex -outdir bin mexFiles/binMyWayMex.c CFLAGS='$CFLAGS -std=c99 -Wall -pedantic -Wextra -O3  '
    end
end


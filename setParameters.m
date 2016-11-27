% parameters
paintParameters=struct('T', 50/255, ...         % Approximation threshold 
    'R', [8   4   2   1], ...     % Brush sizes 
    'fc', 1,...        % Curvature Filter  Used to limit or exaggerate stroke curvature.
    'fo', 1,...        % Blur Factor 
    'minLength', 4,... % Used to restrict the possible stroke lengths. 
    'maxLength', 16,...% Used to restrict the possible stroke lengths. 
    'alpha',     1,... % Specifies the paint opacity, between 0 and 1
    'fg',        1,... % Grid size Controls the spacing of brush strokes.
    'jhsv',[0 0 0],... % Color Jitter ? Factors to randomly add jitter to hue (jh), saturation (js), value (jv), 
    'jrgb',[0 0 0]);   %  red (jr), green (jg) or blue (jb) color components. 0 means no random jitter; larger values increase the factor.
    
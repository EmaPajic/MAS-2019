function avg = averagedata (dt, points)
% function - averagedata
% average rows of [dt] in [points]
    avg = 1;
    for m = 1 : length(points)
        correction = 0;
    	    if (m == 1)
        		avg = dt{points(m)}{5};
            else
        		if isnan(dt{points(m)}{5}(1,1))
        			correction = correction + 1; % for the trial with no numeric data
        			% warning('NaN encountered')
                else
        			avg = ((avg * (m - 1 - correction)) + dt{points(m)}{5}) / (m - correction);
        		end
            end
    end
function delIfExi(varargin)
for k = 1:nargin
    if exist(varargin{k})
        delete(varargin{k})
    end
end
end
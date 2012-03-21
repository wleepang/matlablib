function stOptsOut = pvargs(stDefaults, cPVList)
% pvargs: processes a list of property/value pairs, with defaults
% usage: stOptsOut = pvargs(stDefaults, cPVList)
%
% Arguments
% stDefaults 
%       A structure with fields for every potential property/value pair
%       where field names are the property names and field values are the
%       property defaults.  Properties without a default value are
%       specified as empty ([]).
%
% cPVList
%       A cell array of property/value pairs where property names are
%       specified before values.  Property name processing is case
%       insensitive and allows for unambiguous name shortening.  Value
%       class types are also compared to the class type of the supplied
%       defaults.  A warning is issued if the classes do not agree.
%
% Outputs
% stOptsOut
%       A structure with the same fields as stDefaults but with values
%       updated according to the property/value pair list provided.
%
% Example usage:
%       Set defaults
%          dflts.foo = 1;
%          dflts.bar = 'monkey';
%          dflts.foofoo = {1, '11'};
%
%       Update the values based on a property/value list
%           newvals = pvargs(dflts, {'f', 2, 'bar', 'chimp'});
%
%       Note, an error will result from the above statement:
%           ??? Error using ==> pvargs
%           'f' is ambiguous with: foo, foofoo,
%
%       Trying:
%           newvals = pvargs(dflts, {'foo', 2, 'bar', 'chimp'});
%
%       Gives:
%           newvals = 
%              foo: 2
%              bar: 'chimp'
%           foofoo: {[1]  '11'}

% Todo
% Incorporate value constraints
% Allow for flags.

% preset all the default values;
stOptsOut = stDefaults;

opts = struct([]);
args = cPVList;
if ~isempty(args),
    % there are options
    if mod(length(args),2) == 0,
        optn = 0;
        for iOpt = 1:2:length(args),
            optn = optn + 1;
            param = lower(args{iOpt});
            value = args{iOpt+1};
            
            % check that param/value pairs are supplied in the correct
            % order - e.g. param first!
            if ~ischar(param),
                err = sprintf(...
                    ['Error at parameter %d.\n', ...
                     'Parameter names must be of type CHAR'], optn);
                error(err);
            end
            
            opts(1).(param) = value;
        end;
    else
        error('optional arguments must be supplied as Param,Value pairs');
    end;
end;

if ~isempty(opts),
    optnames = fieldnames(opts);
    validnames = fieldnames(stDefaults);
    for i = 1:length(optnames),
        optname = optnames{i};
        iOpt = strmatch(lower(optname), lower(validnames), 'exact');
        bOptFound = true;
        if isempty(iOpt),
            % check for shortened param name
            iOpt = find(strncmpi(optname, validnames, length(optname)));

            if isempty(iOpt),
                % the param name is not found
                warning('pvargs:IgnoredInvalidParamName',['''' optname ''' is not a valid parameter name. Ignored']);
                bOptFound = false;
            elseif length(iOpt) > 1,
                % the param name is ambiguous with other parameters
                ambopts = sprintf('%s, ', validnames{iOpt});
                error(['The parameter ''' optname ''' is ambiguous with: ' ambopts(1:end-1)]);
            end;

        end;
        
        if bOptFound,
            stOptsOut.(validnames{iOpt}) = opts.(optname);

            vlCls = class(opts.(optname));
            dfCls = class(stDefaults.(validnames{iOpt}));

            % test to make sure that the class of the supplied value is the same as
            % the specified default
            if ~strcmpi(dfCls, vlCls),
                % since some classes are cross compatible (logical <-> numeric)
                % just give a warning
                warning('parseopts:ClassMismatch', ...
                    ['The class of the value for ''' validnames{iOpt} ...
                     ''' (' vlCls ') does not match the default (' dfCls ')']);
            end;
        end;
    end;
end;
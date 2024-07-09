local a_name, a_env = ...

function a_env.OnNextUpdateOnce(callback)
   return function() C_Timer.After(0, callback) end
end

function a_env.OnAddOnLoadedAndNextUpdateOnce(args)
   local on_next_frame = a_env.OnNextUpdateOnce(args['then'])

   if args.already_loaded and args.already_loaded() then
      on_next_frame()
   else
      EventUtil.ContinueOnAddOnLoaded(args.addon, on_next_frame)
   end
end

local a_name, a_env = ...

function a_env.HookFreezeSetPoint(frame, hook_func)
   local original_setpoint = frame.SetPoint

   hook_func(frame, original_setpoint)
   hooksecurefunc(frame, "SetPoint", function(frame, ...)
      hook_func(frame, original_setpoint, ...)
   end)
end

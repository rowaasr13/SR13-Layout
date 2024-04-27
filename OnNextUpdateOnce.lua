local a_name, a_env = ...

function a_env.OnNextUpdateOnce(callback)
   return function() C_Timer.After(0, callback) end
end

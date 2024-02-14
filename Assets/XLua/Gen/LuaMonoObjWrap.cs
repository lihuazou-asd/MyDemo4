#if USE_UNI_LUA
using LuaAPI = UniLua.Lua;
using RealStatePtr = UniLua.ILuaState;
using LuaCSFunction = UniLua.CSharpFunctionDelegate;
#else
using LuaAPI = XLua.LuaDLL.Lua;
using RealStatePtr = System.IntPtr;
using LuaCSFunction = XLua.LuaDLL.lua_CSFunction;
#endif

using XLua;
using System.Collections.Generic;


namespace XLua.CSObjectWrap
{
    using Utils = XLua.Utils;
    public class LuaMonoObjWrap 
    {
        public static void __Register(RealStatePtr L)
        {
			ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			System.Type type = typeof(LuaMonoObj);
			Utils.BeginObjectRegister(type, L, translator, 0, 2, 0, 0);
			
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "AddOrRemovePhysicsListener", _m_AddOrRemovePhysicsListener);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "AddOrRemoveListener", _m_AddOrRemoveListener);
			
			
			
			
			
			Utils.EndObjectRegister(type, L, translator, null, null,
			    null, null, null);

		    Utils.BeginClassRegister(type, L, __CreateInstance, 1, 0, 0);
			
			
            
			
			
			
			Utils.EndClassRegister(type, L, translator);
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int __CreateInstance(RealStatePtr L)
        {
            
			try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
				if(LuaAPI.lua_gettop(L) == 1)
				{
					
					var gen_ret = new LuaMonoObj();
					translator.Push(L, gen_ret);
                    
					return 1;
				}
				
			}
			catch(System.Exception gen_e) {
				return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
			}
            return LuaAPI.luaL_error(L, "invalid arguments to LuaMonoObj constructor!");
            
        }
        
		
        
		
        
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_AddOrRemovePhysicsListener(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                LuaMonoObj gen_to_be_invoked = (LuaMonoObj)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 4&& translator.Assignable<UnityEngine.Events.UnityAction<UnityEngine.Collider2D>>(L, 2)&& translator.Assignable<E_LifeFun_Type>(L, 3)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 4)) 
                {
                    UnityEngine.Events.UnityAction<UnityEngine.Collider2D> _fun = translator.GetDelegate<UnityEngine.Events.UnityAction<UnityEngine.Collider2D>>(L, 2);
                    E_LifeFun_Type _type;translator.Get(L, 3, out _type);
                    bool _IsAdd = LuaAPI.lua_toboolean(L, 4);
                    
                    gen_to_be_invoked.AddOrRemovePhysicsListener( _fun, _type, _IsAdd );
                    
                    
                    
                    return 0;
                }
                if(gen_param_count == 3&& translator.Assignable<UnityEngine.Events.UnityAction<UnityEngine.Collider2D>>(L, 2)&& translator.Assignable<E_LifeFun_Type>(L, 3)) 
                {
                    UnityEngine.Events.UnityAction<UnityEngine.Collider2D> _fun = translator.GetDelegate<UnityEngine.Events.UnityAction<UnityEngine.Collider2D>>(L, 2);
                    E_LifeFun_Type _type;translator.Get(L, 3, out _type);
                    
                    gen_to_be_invoked.AddOrRemovePhysicsListener( _fun, _type );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to LuaMonoObj.AddOrRemovePhysicsListener!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_AddOrRemoveListener(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                LuaMonoObj gen_to_be_invoked = (LuaMonoObj)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 4&& translator.Assignable<UnityEngine.Events.UnityAction>(L, 2)&& translator.Assignable<E_LifeFun_Type>(L, 3)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 4)) 
                {
                    UnityEngine.Events.UnityAction _fun = translator.GetDelegate<UnityEngine.Events.UnityAction>(L, 2);
                    E_LifeFun_Type _type;translator.Get(L, 3, out _type);
                    bool _IsAdd = LuaAPI.lua_toboolean(L, 4);
                    
                    gen_to_be_invoked.AddOrRemoveListener( _fun, _type, _IsAdd );
                    
                    
                    
                    return 0;
                }
                if(gen_param_count == 3&& translator.Assignable<UnityEngine.Events.UnityAction>(L, 2)&& translator.Assignable<E_LifeFun_Type>(L, 3)) 
                {
                    UnityEngine.Events.UnityAction _fun = translator.GetDelegate<UnityEngine.Events.UnityAction>(L, 2);
                    E_LifeFun_Type _type;translator.Get(L, 3, out _type);
                    
                    gen_to_be_invoked.AddOrRemoveListener( _fun, _type );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to LuaMonoObj.AddOrRemoveListener!");
            
        }
        
        
        
        
        
        
		
		
		
		
    }
}

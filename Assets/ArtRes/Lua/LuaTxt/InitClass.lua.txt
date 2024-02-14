--常用别名都在这里面定位
--准备我们自己之前导入的脚本
--面向对象相关
require("Object")
--字符串拆分
require("SplitTools")
--Json解析
Json = require("JsonUtility")
--协程
util = require("util")

--Unity相关的
GameObject = CS.UnityEngine.GameObject
Resources = CS.UnityEngine.Resources
Transform = CS.UnityEngine.Transform
RectTransform = CS.UnityEngine.RectTransform
TextAsset = CS.UnityEngine.TextAsset
Animator = CS.UnityEngine.Animator
RuntimeAnimatorController = CS.UnityEngine.RuntimeAnimatorController
Sprite = CS.UnityEngine.Sprite
RenderTexture = CS.UnityEngine.RenderTexture
Camera = CS.UnityEngine.Camera
Time = CS.UnityEngine.Time
WaitForSeconds = CS.UnityEngine.WaitForSeconds
KeyCode = CS.UnityEngine.KeyCode
Quaternion = CS.UnityEngine.Quaternion
Rigidbody2D = CS.UnityEngine.Rigidbody2D
Collider2D = CS.UnityEngine.Collider2D
--输入控制
Input = CS.UnityEngine.Input

MainCamera = GameObject.Find("MainCamera").transform
MainCameraComponent = MainCamera:GetComponent("Camera")
persistentDataPath = CS.UnityEngine.Application.persistentDataPath
--图集对象类
SpriteAtlas = CS.UnityEngine.U2D.SpriteAtlas

Vector3 = CS.UnityEngine.Vector3
Vector2 = CS.UnityEngine.Vector2

--UI相关
UI = CS.UnityEngine.UI
Image = UI.Image
Text = UI.Text
Button = UI.Button
Toggle = UI.Toggle
Slider = UI.Slider
ScrollRect = UI.ScrollRect
RawImage = UI.RawImage
Canvas = GameObject.Find("Canvas").transform
roleRenderCamera = GameObject.Find("Camera").transform:GetComponent(typeof(Camera))
BackImage = Canvas:Find("RawImage")

--2D物体相关
SpriteRenderer = CS.UnityEngine.SpriteRenderer
Space = CS.UnityEngine.Space
--UI脚本初始化
require("MainPanel")
require("SetPanel")
require("StartPanel")
require("RoleGrid")
--角色Mono初始化
require("RoleControl")
require("WeaponControl")
--怪物Mono初始化
require("MonsterControl")
--子弹Mono初始化
require("BulletControl")
--管理器初始化
require("UIMgr")
require("GameLevelMgr")

--读取json文件
require("GameDataMgr")

--自己写的C#脚本相关
--直接得到AB包资源管理器的 单例对象
ABMgr = CS.ABMgr.GetInstance()

ABUpdateMgr = CS.ABUpdateMgr.Instance

LuaMonoObj = CS.LuaMonoObj
E_LifeFun_Type = CS.E_LifeFun_Type

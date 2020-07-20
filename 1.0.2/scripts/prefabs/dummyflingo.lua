require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/dummyflingo.zip"),
	    Asset("ANIM", "anim/firefighter_placement.zip"),

}

local prefabs =
{
    "collapse_small",
	"firesuppressor_placer",
	"firesuppressor"

}


local function onhammered(inst, worked)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end

	inst.components.dummyflingoCounter:loadLoot(inst)

    inst.components.lootdropper:DropLoot()
    SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst.SoundEmitter:PlaySound("dontstarve/common/destroy_metal")
		inst.components.dummyflingoCounter:Remove()
    inst:Remove()
end


local function onhit(inst, worker)
	inst.components.dummyflingoCounter:UpdateHammerHits()
	local hammerHits = inst.components.dummyflingoCounter:getHammerHits()
     inst.components.workable:SetMaxWork(5-hammerHits)

	 if (inst.components.dummyflingoCounter:isIncomplete())
	 then     inst.AnimState:PlayAnimation("hit")
              inst.AnimState:PushAnimation("idle",true)
	 elseif not inst.components.dummyflingoCounter:isIncomplete()
	 then     inst.AnimState:PlayAnimation("wip_hit")
              inst.AnimState:PushAnimation("wip_idle",true)
	 end

end

local function getstatus(inst)
        STRINGS.CHARACTERS.GENERIC.DESCRIBE.DUMMYFLINGO = inst.components.dummyflingoCounter:getStatus()
        return "dummyflingoStatus"
end

local function onbuilt(inst)
    inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/firesupressor_craft")
   -- inst.AnimState:PushAnimation("idle")

  local isTest = mods.dummyflingo.test
  if isTest == 1 then
    for i = 0,2 do
	  local gears = SpawnPrefab("gears")
      local pt = Vector3(inst.Transform:GetWorldPosition()) + Vector3(0,20,0)
      gears.Transform:SetPosition(pt:Get())
      local down = TheCamera:GetDownVec()
      local angle = math.atan2(down.z, down.x) + (math.random()*60)*DEGREES
      local sp = 3 + math.random()
      gears.Physics:SetVel(sp*math.cos(angle), math.random()*2+8, sp*math.sin(angle))
	 end

	     for i = 0,2 do
	  local doodad = SpawnPrefab("cutstone")
      local pt = Vector3(inst.Transform:GetWorldPosition()) + Vector3(0,20,0)
      doodad.Transform:SetPosition(pt:Get())
      local down = TheCamera:GetDownVec()
      local angle = math.atan2(down.z, down.x) + (math.random()*60)*DEGREES
      local sp = 3 + math.random()
      doodad.Physics:SetVel(sp*math.cos(angle), math.random()*2+8, sp*math.sin(angle))
	 end
	 	     for i = 0,15 do
	  local ice = SpawnPrefab("ice")
      local pt = Vector3(inst.Transform:GetWorldPosition()) + Vector3(0,20,0)
      ice.Transform:SetPosition(pt:Get())
      local down = TheCamera:GetDownVec()
      local angle = math.atan2(down.z, down.x) + (math.random()*60)*DEGREES
      local sp = 3 + math.random()
      ice.Physics:SetVel(sp*math.cos(angle), math.random()*2+8, sp*math.sin(angle))
	 end

	 	 	     for i = 0,4 do
	  local gold = SpawnPrefab("goldnugget")
      local pt = Vector3(inst.Transform:GetWorldPosition()) + Vector3(0,20,0)
      gold.Transform:SetPosition(pt:Get())
      local down = TheCamera:GetDownVec()
      local angle = math.atan2(down.z, down.x) + (math.random()*60)*DEGREES
      local sp = 3 + math.random()
      gold.Physics:SetVel(sp*math.cos(angle), math.random()*2+8, sp*math.sin(angle))
	 end
   end
end
----------------------------------------

local function AcceptTest(inst, item)
    return inst.components.dummyflingoCounter:isAccept(item)

end

local function OnRefuseItem(inst, giver, item)

end


local function OnGivenItem(inst, giver, item)
   if (inst.components.dummyflingoCounter:isIncomplete())
   then     inst.AnimState:PlayAnimation("turning",true)
             inst.AnimState:PushAnimation("wip_idle",true)
	elseif not (inst.components.dummyflingoCounter:isComplete())
	then    	inst.AnimState:PlayAnimation("update")
	           inst.AnimState:PushAnimation("wip_idle",true)
   end

        inst.SoundEmitter:PlaySound("dontstarve/common/chesspile_repair")
	  SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	  inst.components.dummyflingoCounter:Update(inst, item)

	if (inst.components.dummyflingoCounter:isComplete())
	  then
    inst.SoundEmitter:PlaySound("dontstarve/common/chesspile_ressurect")
	  SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
      SpawnPrefab("firesuppressor").Transform:SetPosition(inst.Transform:GetWorldPosition())
	  inst.components.dummyflingoCounter:Remove()
	  inst:Remove()
	end

end

local function OnRepaired(inst, doer)
   if (inst.components.dummyflingoCounter:isIncomplete())
   then     inst.AnimState:PlayAnimation("turning")
             inst.AnimState:PushAnimation("wip_idle",true)
	elseif not (inst.components.dummyflingoCounter:isComplete())
	then    	inst.AnimState:PlayAnimation("update")
	           inst.AnimState:PushAnimation("wip_idle",true)
   end

        inst.SoundEmitter:PlaySound("dontstarve/common/chesspile_repair")
        SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
		inst.components.dummyflingoCounter:UpdateProgressOnGear(inst)

    if (inst.components.dummyflingoCounter:isComplete()) then
        inst.SoundEmitter:PlaySound("dontstarve/common/chesspile_ressurect")
		    SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
		      SpawnPrefab("firesuppressor").Transform:SetPosition(inst.Transform:GetWorldPosition())
	  inst.components.dummyflingoCounter:Remove()
	  inst:Remove()
    end
end

local function onsave(inst, data)

end

local function onload(inst, data)
  if not (inst.components.dummyflingoCounter:isIncomplete())
  then inst.AnimState:PlayAnimation("wip_idle",true)

  local progressOnGear = inst.components.dummyflingoCounter:getProgressOnGear()
      inst.components.workable:SetWorkLeft(3+progressOnGear)
     inst.components.workable:SetMaxWork(5)
  end
end
--------------------------------------------------------------

local PLACER_SCALE = 1.55

local function OnEnableHelper(inst, enabled)
    if enabled then
        if inst.helper == nil then
            inst.helper = CreateEntity()

      
            inst.helper.entity:SetCanSleep(false)
            inst.helper.persists = false

            inst.helper.entity:AddTransform()
            inst.helper.entity:AddAnimState()

            inst.helper:AddTag("CLASSIFIED")
            inst.helper:AddTag("NOCLICK")
            inst.helper:AddTag("placer")

            inst.helper.Transform:SetScale(PLACER_SCALE, PLACER_SCALE, PLACER_SCALE)

            inst.helper.AnimState:SetBank("firefighter_placement")
            inst.helper.AnimState:SetBuild("firefighter_placement")
            inst.helper.AnimState:PlayAnimation("idle",true)
            inst.helper.AnimState:SetLightOverride(1)
            inst.helper.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
            inst.helper.AnimState:SetLayer(LAYER_BACKGROUND)
            inst.helper.AnimState:SetSortOrder(1)
            inst.helper.AnimState:SetAddColour(0, .2, .5, 0)

            inst.helper.entity:SetParent(inst.entity)
        end
    elseif inst.helper ~= nil then
        inst.helper:Remove()
        inst.helper = nil
    end
end


local function fn(Sim)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

MakeObstaclePhysics(inst, 1)

    local minimap = inst.entity:AddMiniMapEntity()
    inst.MiniMapEntity:SetIcon("minimap_dummyflingo.tex")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst.AnimState:SetBank("dummyflingo")
    inst.AnimState:SetBuild("dummyflingo")
	    inst.AnimState:PlayAnimation("idle",true)

    inst:AddTag("structure")

	    if not TheNet:IsDedicated() then
        inst:AddComponent("deployhelper")
        inst.components.deployhelper.onenablehelper = OnEnableHelper
    end
    inst:AddComponent("dummyflingoCounter")
    inst:AddComponent("lootdropper")

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = getstatus

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(3)
     inst.components.workable:SetMaxWork(5)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)

    inst:AddComponent("repairable")
    inst.components.repairable.repairmaterial = MATERIALS.GEARS
    inst.components.repairable.onrepaired = OnRepaired

	    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(AcceptTest)
    inst.components.trader.onaccept = OnGivenItem
    inst.components.trader.onrefuse = OnRefuseItem
    inst.components.trader.deleteitemonaccept = true

    MakeLargeBurnable(inst, nil, nil, true)

    MakeLargePropagator(inst)

	    inst.OnSave = onsave 
        inst.OnLoad = onload

	inst:ListenForEvent( "onbuilt", onbuilt)

    return inst
end



local function placer_postinit_fn(inst)
    --Show the flingo placer on top of the flingo range ground placer

    local placer2 = CreateEntity()

    placer2.entity:SetCanSleep(false)
    placer2.persists = false

    placer2.entity:AddTransform()
    placer2.entity:AddAnimState()

    placer2:AddTag("CLASSIFIED")
    placer2:AddTag("NOCLICK")
    placer2:AddTag("placer")

    local s = 1 / PLACER_SCALE
    placer2.Transform:SetScale(s, s, s)

    placer2.AnimState:SetBank("dummyflingo")
    placer2.AnimState:SetBuild("dummyflingo")
    placer2.AnimState:PlayAnimation("idle",true)
    placer2.AnimState:SetLightOverride(1)

    placer2.entity:SetParent(inst.entity)

    inst.components.placer:LinkEntity(placer2)
end


return Prefab("common/dummyflingo", fn, assets, prefabs),
 MakePlacer("common/dummyflingo_placer", "firefighter_placement", "firefighter_placement", "idle", true, nil, nil, PLACER_SCALE, nil, nil, placer_postinit_fn)


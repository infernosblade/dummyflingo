local dummyflingoCounter = Class(function(self, inst)
	self.inst = inst
	self.placer = nil

        self.progressOnCutstone = 0
       self.progressOnIce = 0
        self.progressOnGold = 0
		self.progressOnGear = 0
		self.hammerHits = 0
end)

function dummyflingoCounter:Update(inst, item)

     if item.prefab == "cutstone"
          then self.progressOnCutstone = self.progressOnCutstone+1
      elseif item.prefab == "ice"
          then self.progressOnIce = self.progressOnIce+1
	  elseif item.prefab == "goldnugget"
		   then self.progressOnGold = self.progressOnGold+1
      end
end
function dummyflingoCounter:UpdateHammerHits()
self.hammerHits = self.hammerHits+1
end

function dummyflingoCounter:getHammerHits()
return self.hammerHits
end

function dummyflingoCounter:isComplete()
local isComplete = ((self.progressOnCutstone == 2) and (self.progressOnIce == 15) and (self.progressOnGold == 4) and (self.progressOnGear == 2))
return isComplete
end

function dummyflingoCounter:isIncomplete()
local isIncomplete = ((self.progressOnCutstone == 0) and (self.progressOnIce == 0) and (self.progressOnGold == 0) and (self.progressOnGear == 0))
return isIncomplete
end

function dummyflingoCounter:UpdateProgressOnGear(inst)
self.progressOnGear = self.progressOnGear+1
end

function dummyflingoCounter:isAccept(item)
      return 
	     ((item.prefab == "ice") and (self.progressOnIce < 15)) 
	  or ((item.prefab == "cutstone") and (self.progressOnCutstone < 2))
	  or ((item.prefab == "goldnugget") and (self.progressOnGold < 4))
	--  or ((item.prefab == "gears") and (self.progressOnGear < 2))
end

function dummyflingoCounter:getProgressOnGear()
return self.progressOnGear
end

function dummyflingoCounter:getStatus()
return
string.format("I need %1d more cut stone, %1d more gold nugget, %1d more gear and %2d more ice", 2-self.progressOnCutstone, 4-self.progressOnGold, 2-self.progressOnGear, 15-self.progressOnIce, self.hammerHits, 5-self.hammerHits)
end

function dummyflingoCounter:OnSave()
    return
    {  
       progressOnCutstone = self.progressOnCutstone,
        progressOnGear = self.progressOnGear,
		progressOnGold = self.progressOnGold,
		progressOnIce = self.progressOnIce,

	}
end

function dummyflingoCounter:OnLoad(data)
	if data ~= nil then

		self.progressOnCutstone = data.progressOnCutstone
        self.progressOnGear = data.progressOnGear
		self.progressOnGold = data.progressOnGold
		self.progressOnIce = data.progressOnIce
		self.hammerHits  = 0
	end
end

function dummyflingoCounter:loadLoot(inst)

		for loadingCutstone = self.progressOnCutstone, 1, -1
		do inst.components.lootdropper:AddChanceLoot("cutstone", 1)
		end
		for loadingGear = self.progressOnGear, 1, -1
		do inst.components.lootdropper:AddChanceLoot("gears",1)
		end
		for loadingGold = self.progressOnGold, 1, -1
		do inst.components.lootdropper:AddChanceLoot("goldnugget",1)
		end
		for loadingIce = self.progressOnIce, 1, -1
		do inst.components.lootdropper:AddChanceLoot("ice",1)
		end

end

function dummyflingoCounter:Remove()
	if self.placer ~= nil then
		self.placer:Remove()
		self.placer = nil
	end
end

return dummyflingoCounter
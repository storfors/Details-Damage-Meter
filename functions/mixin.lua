
local Details = _G.Details
local detailsFramework = _G.DetailsFramework
local openRaidLib = LibStub:GetLibrary("LibOpenRaid-1.0", true)
local addonName, Details222 = ...

Details222.Mixins.ActorMixin = {
	---return a spellContainer from an actor
	---@param actor actor
	---@param containerType string
	---@return spellcontainer|nil
	GetSpellContainer = function(actor, containerType)
		if (containerType == "debuff") then
			return actor.debuff_uptime_spells

		elseif (containerType == "buff") then
			return actor.buff_uptime_spells

		elseif (containerType == "spell") then
			return actor.spells

		elseif (containerType == "cooldowns") then
			return actor.cooldowns_defensive_spells
		end
	end,

	---return a spellTable from a spellContainer
	---@param actor actor
	---@param spellContainerName string
	---@param spellId number
	---@return spelltable|nil
	GetSpellTableFromContainer = function(actor, spellContainerName, spellId)
		---@type spellcontainer
		local spellContainer = actor[spellContainerName]
		if (spellContainer) then
			---@type spelltable
			local spellTable = spellContainer._ActorTable[spellId]
			return spellTable
		end
	end,

	---return a table containing pet names
	---@param actor actor
	---@return table<number, string>
	GetPets = function(actor)
		return actor.pets
	end,

	---return a table containing spellTables
	---@param actor actor
	---@return table<number, spelltable>
	GetSpellList = function(actor)
		return actor.spells._ActorTable
	end,

	---this function sums all the targets of all spellTables conteining on a 'breakdownspelldata'
	---@param actor actor
	---@param bkSpellData breakdownspelldata
	---@param targetTableName string
	---@return table<string, number>
	BuildSpellTargetFromBreakdownSpellData = function(actor, bkSpellData, targetTableName)
		targetTableName = targetTableName or "targets"

		local spellTables = bkSpellData.spellTables

		---@type table<string, number> store the index of the target name in the result table
		local cacheIndex = {}
		---@type table<string, number> store the result which is returned by this function
		local result = {}

		for i = 1, #spellTables do
			---@type spelltable
			local spellTable = spellTables[i]
			---@type table<string, number>
			local targets = spellTable[targetTableName]

			for targetName, value in pairs(targets) do
				local index = cacheIndex[targetName]
				if (index) then
					result[index][2] = result[index][2] + value
				else
					result[#result+1] = {targetName, value}
					cacheIndex[targetName] = #result
				end
			end
		end

		table.sort(result, function(t1, t2)
			return t1[2] > t2[2]
		end)

		return result
	end,

	---this function receives a target table name and return a table containing the targets and the damage done in order of bigger to lower value
	---@param actor actor
	---@param spellTable spelltable
	---@param targetTableName string
	---@return table<string, number>
	BuildSpellTargetFromSpellTable = function(actor, spellTable, targetTableName)
		targetTableName = targetTableName or "targets"

		---@type table<string, number>[] store the result which is returned by this function
		local result = {}

		---@type table<string, number>
		local targets = spellTable[targetTableName]

		for targetName, value in pairs(targets) do
			---@cast targetName string
			---@cast value number
			result[#result+1] = {targetName, value}
		end

		table.sort(result, function(t1, t2)
			return t1[2] > t2[2]
		end)

		return result
	end,



}

--need to transfer the function bellow to another file

--this are the fields from spellTable that can be summed
local spellTable_FieldsToSum = {
	["counter"] = true,
	["total"] = true,
	["c_amt"] = true,
	["c_min"] = true,
	["c_max"] = true,
	["c_total"] = true,
	["n_amt"] = true,
	["n_total"] = true,
	["n_min"] = true,
	["n_max"] = true,
	["successful_casted"] = true,
	["g_amt"] = true,
	["g_dmg"] = true,
	["r_amt"] = true,
	["r_dmg"] = true,
	["b_amt"] = true,
	["b_dmg"] = true,
	["a_amt"] = true,
	["a_dmg"] = true,
	["totalabsorb"] = true,
	["absorbed"] = true,
	["overheal"] = true,
	["totaldenied"] = true,
}

---get the array of spelltables and sum each spellTable with the first spellTable found or on targetTable
---only sum the keys found in the spellTable_FieldsToSum table
---@param spellTables table<number, spelltable>[]
---@param targetTable table
function Details:SumSpellTables(spellTables, targetTable)
	local amtSpellTables = #spellTables

	if (amtSpellTables == 0) then
		return
	end

	targetTable = targetTable or spellTables[1]

	for i = 1, amtSpellTables do
		---@type spelltable
		local spellTable = spellTables[i]
		if (spellTable) then
			for key, value in pairs(spellTable) do
				if (spellTable_FieldsToSum[key]) then
					targetTable[key] = (targetTable[key] or 0) + value
				end
			end
		end
	end
end


---@alias plugintype
---| "SOLO"
---| "RAID"
---| "TOOLBAR"
---| "STATUSBAR"

---@alias containertype number this container type is the number used to identify the actorcontainer type when using combat:GetContainer(containertype), can be 1, 2, 3, or 4.

---@class details
---@field SpellTableMixin spelltablemixin
---@field GetInstance fun(self: details) : instance
---@field GetWindow fun(self: details) : instance this is an alias of GetInstance
---@field GetCombat fun(self: details) : combat
---@field GetSpellSchoolFormatedName fun(self: details, spellschool: spellschool) : string
---@field CommaValue fun(self: details, number: number) : string
---@field CreateEventListener fun(self: details) : table

---@class detailseventlistener : table
---@field RegisterEvent fun(self: detailseventlistener, event: "DETAILS_INSTANCE_OPEN"|"DETAILS_INSTANCE_CLOSE"|"DETAILS_INSTANCE_SIZECHANGED"|"DETAILS_INSTANCE_STARTRESIZE"|"DETAILS_INSTANCE_ENDRESIZE"|"DETAILS_INSTANCE_STARTSTRETCH"|"DETAILS_INSTANCE_ENDSTRETCH"|"DETAILS_INSTANCE_CHANGESEGMENT"|"DETAILS_INSTANCE_CHANGEATTRIBUTE"|"DETAILS_INSTANCE_CHANGEMODE"|"DETAILS_INSTANCE_NEWROW"|"DETAILS_OPTIONS_MODIFIED"|"DETAILS_DATA_RESET"|"DETAILS_DATA_SEGMENTREMOVED"|"COMBAT_ENCOUNTER_START"|"COMBAT_ENCOUNTER_END"|"COMBAT_PLAYER_ENTER"|"COMBAT_PLAYER_LEAVE"|"COMBAT_PLAYER_TIMESTARTED"|"COMBAT_BOSS_WIPE"|"COMBAT_BOSS_DEFEATED"|"COMBAT_BOSS_FOUND"|"COMBAT_INVALID"|"COMBAT_PREPOTION_UPDATED"|"COMBAT_CHARTTABLES_CREATING"|"COMBAT_CHARTTABLES_CREATED"|"COMBAT_ENCOUNTER_PHASE_CHANGED"|"COMBAT_ARENA_START"|"COMBAT_ARENA_END"|"COMBAT_MYTHICDUNGEON_START"|"COMBAT_MYTHICDUNGEON_END"|"GROUP_ONENTER"|"GROUP_ONLEAVE"|"ZONE_TYPE_CHANGED"|"REALM_CHANNEL_ENTER"|"REALM_CHANNEL_LEAVE"|"COMM_EVENT_RECEIVED"|"COMM_EVENT_SENT"|"UNIT_SPEC"|"UNIT_TALENTS"|"PLAYER_TARGET"|"DETAILS_PROFILE_APPLYED", callback: function)
---@field UnregisterEvent fun(self: detailseventlistener, event: "DETAILS_INSTANCE_OPEN"|"DETAILS_INSTANCE_CLOSE"|"DETAILS_INSTANCE_SIZECHANGED"|"DETAILS_INSTANCE_STARTRESIZE"|"DETAILS_INSTANCE_ENDRESIZE"|"DETAILS_INSTANCE_STARTSTRETCH"|"DETAILS_INSTANCE_ENDSTRETCH"|"DETAILS_INSTANCE_CHANGESEGMENT"|"DETAILS_INSTANCE_CHANGEATTRIBUTE"|"DETAILS_INSTANCE_CHANGEMODE"|"DETAILS_INSTANCE_NEWROW"|"DETAILS_OPTIONS_MODIFIED"|"DETAILS_DATA_RESET"|"DETAILS_DATA_SEGMENTREMOVED"|"COMBAT_ENCOUNTER_START"|"COMBAT_ENCOUNTER_END"|"COMBAT_PLAYER_ENTER"|"COMBAT_PLAYER_LEAVE"|"COMBAT_PLAYER_TIMESTARTED"|"COMBAT_BOSS_WIPE"|"COMBAT_BOSS_DEFEATED"|"COMBAT_BOSS_FOUND"|"COMBAT_INVALID"|"COMBAT_PREPOTION_UPDATED"|"COMBAT_CHARTTABLES_CREATING"|"COMBAT_CHARTTABLES_CREATED"|"COMBAT_ENCOUNTER_PHASE_CHANGED"|"COMBAT_ARENA_START"|"COMBAT_ARENA_END"|"COMBAT_MYTHICDUNGEON_START"|"COMBAT_MYTHICDUNGEON_END"|"GROUP_ONENTER"|"GROUP_ONLEAVE"|"ZONE_TYPE_CHANGED"|"REALM_CHANNEL_ENTER"|"REALM_CHANNEL_LEAVE"|"COMM_EVENT_RECEIVED"|"COMM_EVENT_SENT"|"UNIT_SPEC"|"UNIT_TALENTS"|"PLAYER_TARGET"|"DETAILS_PROFILE_APPLYED")

---@class customspellinfo : {name: string, isPassive: boolean, itemId: number, icon: string|number}
---@class customiteminfo: {itemId: number, isPassive: boolean}
---@class savedspelldata : {key1: number, key2: string, key3: number}
---@class alternatepowertable : {last: number, total: number}

---@class combat : table
---@field __destroyedBy string
---@field amountCasts {[string]: table<string, number>}
---@field instance_type string "raid" or "party" or "pvp" or "arena" or "none"
---@field end_time number
---@field start_time number
---@field is_trash boolean while in raid this is set to true if the combat isn't raid boss, in dungeon this is set to true if the combat isn't a boss or if the dungeon isn't a mythic+
---@field raid_roster table<string, string> [unitName] = unitGUID
---@field overall_added boolean is true when the combat got added into the overall combat
---@field is_mythic_dungeon_trash boolean
---@field is_mythic_dungeon_run_id number
---@field is_mythic_dungeon_segment boolean
---@field trinketProcs table<actorname, table<spellid, {cooldown: number, total: number}>>
---@field alternate_power table<actorname, alternatepowertable>
---@field totals {key1: table, key2: table, key3: table, key3: table}
---@field totals_grupo {key1: table, key2: table, key3: table, key3: table}
---@field __destroyed boolean
---@field GetTimeData fun(dataName: string) : table
---@field GetPhases fun(combat: combat) : table
---@field GetCombatTime fun(combat) : number
---@field GetDeaths fun(combat) : table --get the table which contains the deaths of the combat
---@field GetStartTime fun(combat: combat) : number
---@field SetStartTime fun(combat: combat, time: number)
---@field GetEndTime fun(combat: combat) : number
---@field GetDifficulty fun(combat: combat) : number return the dungeon or raid difficulty for boss fights
---@field GetEncounterCleuID fun(combat: combat) : number return the encounterId for boss fights, this number is gotten from the ENCOUNTER_START event
---@field GetBossInfo fun(combat: combat) : table a table containing many informations about the boss fight
---@field SetEndTime fun(combat: combat, time: number)
---@field CopyDeathsFrom fun(combat1: combat, combat2: combat, bMythicPlus: boolean) copy the deaths from combat2 to combat1, use true on bMythicPlus if the combat is from a mythic plus run
---@field GetContainer fun(combat: combat, containerType: containertype) : actorcontainer get an actorcontainer, containerType can be 1 for damage, 2 heal, 3 resources, 4 utility
---@field GetSpellCastAmount fun(combat: combat, actorName: string, spellName: string) : number get the amount of times a spell was casted
---@field RemoveActorFromSpellCastTable fun(combat: combat, actorName: string)
---@field GetSpellCastTable fun(combat: combat, actorName: string|nil) : table
---@field GetSpellUptime fun(combat: combat, actorName: string, spellId: number, auraType: string|nil) : number get the uptime of a buff or debuff
---@field GetActor fun(combat: combat, containerType: number, playerName: string) : actor
---@field CreateAlternatePowerTable fun(combat: combat, actorName: string) : alternatepowertable
---@field GetCombatNumber fun(combat: combat) : number get a unique number representing the combatId, each combat has a unique number
---@field SetDate fun(combat: combat, startDate: string, endDate: string) set the start and end date of the combat, format: "H:M:S"
---@field GetDate fun(combat: combat) : string, string get the start and end date of the combat, format: "H:M:S"
---@field GetRoster fun(combat: combat) : table<string, string> get the roster of the combat, the table contains the names of the players in the combat
---@field InstanceType fun(combat: combat) : string get the instance type of the combat, can be "raid" or "party" or "pvp" or "arena" or "none"
---@field IsTrash fun(combat: combat) : boolean is true if the combat is a trash combat

---@class actorcontainer : table contains two tables _ActorTable and _NameIndexTable, the _ActorTable contains the actors, the _NameIndexTable contains the index of the actors in the _ActorTable, making quick to reorder them without causing overhead
---@field need_refresh boolean when true the container is dirty and needs to be refreshed
---@field _ActorTable table array of actors
---@field _NameIndexTable table<string, number> [actorName] = actorIndex in the _ActorTable, actorcontainer:Remap() refreshes the _NameIndexTable
---@field GetActor fun(container: actorcontainer, actorName: string) get an actor by its name
---@field GetSpellSource fun(container: actorcontainer, spellId: number) get the first actor found which casted the spell
---@field GetAmount fun(container: actorcontainer, actorName: string, key: string) get the amount of actor[key]
---@field GetTotal fun(container: actorcontainer, key: string) get the total amount of actor[key] for all actors
---@field GetTotalOnRaid fun(container: actorcontainer, key: string, combat: combat) get the total amount of actor[key] only for the actors which are in the raid
---@field GetActorTable fun(container: actorcontainer) get the table<actorIndex, actorObject> which contains the actors
---@field ListActors fun(container: actorcontainer) usage: for index, actorObject in container:ListActors() do
---@field RemoveActor fun(container: actorcontainer, actor: actor) remove an actor from the container
---@field GetType fun(container: actorcontainer) : number get the container type, 1 for damage, 2 for heal, 3 for energy, 4 for utility
---@field Remap fun(container: actorcontainer) refreshes the _NameIndexTable part of the container
---@field Cleanup fun(container: actorcontainer) remove all destroyed actors from the container

---@class spellcontainer : table
---@field _ActorTable table store [spellId] = spelltable
---@field GetSpell fun(container: spellcontainer, spellId: number) get a spell by its id, does not create if not found
---@field ListActors fun(container: spellcontainer) : any, any usage: for spellId, spelltable in container:ListActors() do
---@field ListSpells fun(container: spellcontainer) : any, any usage: for spellId, spelltable in container:ListActors() do
---@field HasTwoOrMoreSpells fun(container: spellcontainer) : boolean return true if the container has two or more spells
---@field GetOrCreateSpell fun(self: spellcontainer, spellId: number, bCanCreateSpellIfMissing: boolean|nil, cleuToken: string|nil) : spelltable

---@class friendlyfiretable : table
---@field total number total amount of friendly fire caused by the actor
---@field spells table<spellid, number> spellId = total

---@class spelltable : table
---@field uptime number
---@field total number
---@field spellschool number
---@field counter number amount of hits
---@field c_amt number critical hits by a damage or heal spell
---@field c_min number min damage or healing done by critical hits of the spell
---@field c_max number min damage or healing done by critical hits of the spell
---@field c_total number total damage or heal made by critical hits of the spell
---@field n_amt number normal hits by a damage or heal spell
---@field n_min number min damage or healing done by normal hits of the spell
---@field n_max number min damage or healing done by normal hits of the spell
---@field n_total number total damage or heal made by normal hits of the spell
---@field targets table<string, number> store the [target name] = total value
---@field targets_overheal table<string, number>
---@field targets_absorbs table<string, number>
---@field extra table store extra data
---@field id number --spellid
---@field is_shield boolean --true if the spell is a shield
---@field successful_casted number successful casted times (only for enemies)
---@field g_amt number glacing hits
---@field g_dmg number
---@field r_amt number --resisted
---@field r_dmg number
---@field b_amt number --blocked
---@field b_dmg number
---@field a_amt number --absorved
---@field a_dmg number
---@field e_total number
---@field e_amt number
---@field e_lvl table<number, number>
---@field e_dmg table<number, number>
---@field e_heal table<number, number>
---@field isReflection boolean
---@field totalabsorb number healing absorbed
---@field absorbed number damage absorbed by shield | healing absorbed by buff or debuff
---@field overheal number
---@field totaldenied number

---@class targettable : {[string]: number}

---@class actor : table
---@field owner actor
---@field tipo number the container type
---@field ownerName string name of the owner of the pet, a pet without an owner is considered an orphan and be suitable for garbage collection
---@field pets table<number, string>
---@field arena_enemy boolean if true the actor is an enemy in an arena match
---@field dps_started boolean if true the actor started to do damage or healing
---@field start_time unixtime when this actor started to be tracked
---@field end_time number when this actor stopped to be tracked, end_time - start_time is the activity time of the actor
---@field displayName string actor name shown in the regular window
---@field pvp boolean indicates if the actor is a part of a pvp match
---@field flag_original number original actor flag from what was received in the combat log
---@field debuff_uptime_spells table
---@field buff_uptime_spells table
---@field spells spellcontainer
---@field aID number|string actorID is a realm-playername or npcID
---@field spellicon number|string
---@field cooldowns_defensive_spells table
---@field nome string name of the actor
---@field isTank boolean if true the player had the spec TANK during the combat
---@field serial string
---@field spec number
---@field grupo boolean
---@field fight_component boolean
---@field boss_fight_component boolean
---@field pvp_component boolean
---@field boss boolean
---@field last_event unixtime
---@field total_without_pet number
---@field total number
---@field targets targettable
---@field GetSpell fun(actor: actor, spellId: number) : spelltable
---@field BuildSpellTargetFromBreakdownSpellData fun(actor: actor, bkSpellData: spelltableadv) : table
---@field BuildSpellTargetFromSpellTable fun(actor: actor, spellTable: spelltable) : table
---@field raid_targets table<number, number>
---@field IsPlayer fun(actor: actor) : boolean return true if the actor is controlled by a player
---@field IsPetOrGuardian fun(actor: actor) : boolean return true if the actor is a pet or guardian
---@field IsGroupPlayer fun(actor: actor) : boolean return true if the actor is a player in the group (or was in the group during the combat)
---@field GetSpellContainer fun(actor: actor, containerType: "debuff"|"buff"|"spell"|"cooldowns"|"dispel") : spellcontainer
---@field Class fun(actor: actor) : string get the ingame class of the actor
---@field Spec fun(actor: actor) : string get the ingame spec of the actor
---@field Name fun(actor: actor) : string get the name of the actor
---@field Tempo fun(actor: actor) : number get the activity or effective time of the actor
---@field GetPets fun(actor: actor) : table<number, string> get a table with all pet names that belong to the player
---@field GetSpellList fun(actor: actor) : table<number, spelltable>
---@field GetSpellContainerNames fun(container: actorcontainer) : string[] get the table which contains the names of the spell containers

---@class actordamage : actor
---@field friendlyfire_total number
---@field friendlyfire table<actorname, friendlyfiretable>
---@field damage_taken number amount of damage the actor took during the segment
---@field damage_from table<string, boolean> store the name of the actors which damaged the actor, format: [actorName] = true
---@field totalabsorbed number amount of damage dealt by the actor by got absorbed by the target, this is a "ABSORB" type of miss but still counts as damage done

---@class actorheal : actor
---@field healing_taken number amount of healing the actor took during the segment
---@field totalover number amount of healing that was overhealed
---@field totalabsorb number amount of healing that was absorbed
---@field heal_enemy_amt number amount of healing done to enemies this included enemy to enemy heals
---@field totaldenied number amount of healing that was denied by the target - from cleu event SPELL_HEAL_ABSORBED
---@field totalover_without_pet number amount of healing that was overhealed without the pet healing
---@field healing_from table<string, boolean> store the name of the actors which healed the actor, format: [actorName] = true
---@field heal_enemy table<number, number> store the amount of healing done by each spell that landed into an enemy, format: [spellId] = healing done
---@field targets_overheal table<string, number> [targetName] = overheal
---@field targets_absorbs table<string, number> [targetName] = absorbs

---@class actorresource : actor
---@field powertype number power type of the actor
---@field alternatepower number alternate power of the actor

---@class actorutility : actor
---@field cc_break number amount of times the actor broke a cc
---@field interrupt number amount of times the actor interrupted a spell
---@field ress number amount of times the actor ressed a player
---@field dead number amount of times the actor died
---@field cooldowns_defensive number amount of times the actor used a defensive cooldown
---@field buff_uptime number amount of time the actor had a buff
---@field debuff_uptime number amount of time the actor had a debuff
---@field cc_done number amount of times the actor applyed a crowdcontrol on a target
---@field cc_done_targets table<string, number> [targetName] = amount of times the actor cc'd the target
---@field cc_done_spells spellcontainer
---@field dispell number amount of times the actor dispelled a buff or debuff
---@field dispell_spells spellcontainer
---@field dispell_targets table<string, number> [targetName] = amount
---@field dispell_oque table<number, number> [spellId] = amount, amount of times the actor dispelled the spellId

--interrupt_targets interrupt_spells interrompeu_oque
--cc_break_targets cc_break_spells cc_break_oque


---@class segmentid : number
---@class instanceid : number
---@class attributeid : number
---@class modeid : number

---@class instance : table
---@field segmento segmentid
---@field showing combat
---@field meu_id instanceid
---@field is_interacting boolean
---@field modo modeid
---@field atributo attributeid
---@field sub_atributo attributeid
---@field ativa boolean
---@field freezed boolean
---@field sub_atributo_last table
---@field row_info table
---@field GetSize fun(instance: instance) : width, height
---@field GetInstanceGroup fun() : table
---@field GetCombat fun(instance: instance)
---@field ChangeIcon fun(instance: instance)
---@field CheckIntegrity fun(instance: instance)
---@field SetMode fun(instance: instance, mode: modeid)
---@field GetMode fun(instance: instance) : modeid
---@field IsInteracting fun(instance: instance) : boolean
---@field IsLowerInstance fun(instance: instance) : boolean
---@field IsEnabled fun(instance: instance) : boolean
---@field GetId fun(instance: instance) : instanceid
---@field GetSegmentId fun(instance: instance) : segmentid
---@field RefreshCombat fun(instance: instance)
---@field Freeze fun(instance: instance)
---@field UnFreeze fun(instance: instance)
---@field SetSegment fun(instance: instance, segment: segmentid, force: boolean|nil)
---@field GetDisplay fun(instance: instance) : attributeid, attributeid
---@field ResetWindow fun(instance: instance, resetType: number|nil, segmentId: segmentid|nil)
---@field RefreshData fun(instance: instance, force: boolean|nil)
---@field RefreshWindow fun(instance: instance, force: boolean|nil)

---@class trinketdata : table
---@field itemName string
---@field spellName string
---@field lastActivation number
---@field lastPlayerName string
---@field totalCooldownTime number
---@field activations number
---@field lastCombatId number
---@field minTime number
---@field maxTime number
---@field averageTime number

---@class tabframe : frame this is the tab frame object for the breakdown window

---@class breakdownwindow : frame
---@field shownPluginObject table
---@field BreakdownSideMenuFrame frame frame attached to the left or right side of the breakdown window
---@field BreakdownPluginSelectionFrame frame frame which has buttons to select a plugin to show in the breakdown window
---@field BreakdownTabsFrame frame where the tab buttons are located (parent frame)
---@field RegisteredPluginButtons button[] table which contains plugins buttons that are registered to the breakdown window
---@field RegisterPluginButton fun(button: button) register a plugin button to the breakdown window
---@field GetShownPluginObject fun() : table get the plugin object that is currently shown in the breakdown window


---@class breakdownscrolldata : table
---@field totalValue number total done by the actor
---@field combatTime number
---@field [spelltableadv] spelltableadv indexed part of the table

---@class headercolumndatasaved : {enabled: boolean, width: number, align: string}

---@class breakdownexpandbutton : button
---@field texture texture

---@class breakdownspellscrollframe : df_scrollboxmixin, scrollframe
---@field Header df_headerframe
---@field RefreshMe fun(scrollFrame: breakdownspellscrollframe, data: table|nil)
---@field SortKey string
---@field SortOrder string

---@class breakdowntargetscrollframe : df_scrollboxmixin, scrollframe
---@field Header df_headerframe
---@field RefreshMe fun(scrollFrame: breakdowntargetscrollframe, data: table|nil)

---@class breakdowngenericscrollframe : df_scrollboxmixin, scrollframe
---@field Header df_headerframe
---@field RefreshMe fun(scrollFrame: breakdowngenericscrollframe, data: table|nil)

---@class breakdownphasescrollframe : df_scrollboxmixin, scrollframe
---@field Header df_headerframe
---@field RefreshMe fun(scrollFrame: breakdownphasescrollframe, data: table|nil)

---@class breakdownphasebar : button, df_headerfunctions
---@field index number
---@field Icon texture
---@field InLineTexts fontstring[]
---@field statusBar breakdownspellbarstatusbar

---@class breakdowngenericbar : button, df_headerfunctions
---@field index number
---@field rank number
---@field name string
---@field percent number
---@field amount number
---@field total number
---@field actorName string
---@field Icon texture
---@field InLineTexts fontstring[]
---@field statusBar breakdownspellbarstatusbar
---@field bIsFromLeftScroll boolean
---@field bIsFromRightScroll boolean

---@class breakdowntargetbar : button, df_headerfunctions
---@field index number
---@field rank number
---@field name string
---@field percent number
---@field amount number
---@field total number
---@field actorName string
---@field bkTargetData breakdowntargettable
---@field Icon texture
---@field InLineTexts fontstring[]
---@field statusBar breakdownspellbarstatusbar

---@class breakdownspellbar : button, df_headerfunctions
---@field index number
---@field rank number
---@field spellId number
---@field name string
---@field combatTime number
---@field perSecond number
---@field percent number
---@field amountCasts number
---@field average number
---@field castAverage number
---@field onMouseUpTime number GetTime() of when the spellbar got OnMouseUp event
---@field cursorPosX number mouse position when the spellbar got OnMouseDown event
---@field cursorPosY number mouse position when the spellbar got OnMouseDown event
---@field spellTable spelltable
---@field bkSpellData spelltableadv
---@field statusBar breakdownspellbarstatusbar
---@field expandButton breakdownexpandbutton
---@field spellIconFrame frame
---@field spellIcon texture
---@field targetsSquareFrame breakdowntargetframe
---@field targetsSquareTexture texture
---@field overlayTexture texture
---@field bIsExpandedSpell boolean
---@field ExpandedChildren breakdownspellbar[] store the spellbars which are expanded from this spellbar (spellbars shown when the expand button is pressed)
---@field InLineTexts fontstring[]

---@class breakdownspellbarstatusbar : statusbar
---@field backgroundTexture texture
---@field overlayTexture texture
---@field highlightTexture texture

---spelltableadv is similar to spelltable but allow custom members, methods and any modification isn't save to saved variables
---@class spelltableadv : spelltable, spelltablemixin
---@field expanded boolean if is true the show the nested spells
---@field spellTables spelltable[]
---@field nestedData bknesteddata[]
---@field bCanExpand boolean
---@field expandedIndex number
---@field bIsExpanded boolean
---@field statusBarValue number
---@field npcId npcid
---@field actorName string --when showing an actor header, this is the actor name
---@field bIsActorHeader boolean if this is true, the spellbar is an actor header, which is a bar with the actor name with the actor spells nested
---@field actorIcon textureid|texturepath

---@class bknesteddata : {spellId: number, spellTable: spelltable, actorName: string, value: number, bIsActorHeader: boolean} fills .nestedData table in spelltableadv, used to store the nested spells data, 'value' is set when the breakdown sort the values by the selected header

---@class breakdowntargetframe : frame
---@field spellId number
---@field bkSpellData spelltableadv
---@field spellTable spelltable
---@field texture texture
---@field bIsMainLine boolean

---@class breakdowntargettablelist : breakdowntargettable[]
---@field totalValue number
---@field totalValueOverheal number
---@field combatTime number

---@class breakdowntargettable : table
---@field name string
---@field total number
---@field overheal number|nil
---@field absorbed number|nil
---@field statusBarValue number

---@class breakdownspelldatalist : spelltableadv[]
---@field totalValue number
---@field combatTime number

---@class breakdownspellstab : tabframe
---@field SpellScrollFrame breakdownspellscrollframe
---@field SpellBlockFrame breakdownspellblockframe

---@class breakdownspellblockframe : frame container for the spellblocks in the breakdown window
---@field SpellBlocks breakdownspellblock[] array of spellblocks
---@field blocksInUse number number of blocks currently in use
---@field UpdateBlocks fun(self: breakdownspellblockframe) update the blocks
---@field ClearBlocks fun(self: breakdownspellblockframe) clear all blocks
---@field GetBlock fun(self: breakdownspellblockframe, index: number) : breakdownspellblock return the block at the index
---@field GetBlocksInUse fun(self: breakdownspellblockframe) : number return the number of blocks currently in use
---@field GetBlocksAmount fun(self: breakdownspellblockframe) : number return the total blocks created
---@field ShowEmptyBlock fun(self: breakdownspellblockframe, index: number) show the empty block

---@class breakdownspellblock : statusbar breakdownspellblock object which is created inside the breakdownspellblockframe
---@field Lines breakdownspellblockline[]
---@field reportButton button
---@field overlay texture
---@field statusBarTexture texture
---@field sparkTexture texture
---@field gradientTexture texture
---@field backgroundTexture texture
---@field GetLine fun(self: breakdownspellblock, index: number) : breakdownspellblockline
---@field GetLines fun(self: breakdownspellblock) : breakdownspellblockline, breakdownspellblockline, breakdownspellblockline
---@field SetColor fun(self: breakdownspellblock, r: any, g: number|nil, b: number|nil, a: number|nil)

---@class breakdownspellblockline : frame a line inside a breakdownspellblock, there's 3 of them in each breakdownspellblock
---@field leftText fontstring
---@field centerText fontstring
---@field rightText fontstring

---@class breakdownspelltab
---@field selectedSpellBar breakdownspellbar
---@field TabFrame breakdownspellstab
---@field mainAttribute number
---@field subAttribute number
---@field TargetScrollFrame breakdowntargetscrollframe
---@field PhaseScrollFrame breakdownphasescrollframe
---@field GenericScrollFrameLeft breakdowngenericscrollframe
---@field GenericScrollFrameRight breakdowngenericscrollframe
---@field SpellContainerFrame df_framecontainer
---@field BlocksContainerFrame df_framecontainer
---@field TargetsContainerFrame df_framecontainer
---@field PhaseContainerFrame df_framecontainer
---@field GenericContainerFrameLeft df_framecontainer
---@field GenericContainerFrameRight df_framecontainer
---@field GetActor fun() : actor
---@field GetCombat fun() : combat
---@field GetInstance fun() : instance
---@field GetSpellScrollFrame fun() : breakdownspellscrollframe
---@field GetSpellBlockFrame fun() : breakdownspellblockframe
---@field GetTargetScrollFrame fun() : breakdowntargetscrollframe
---@field GetSpellScrollContainer fun() : df_framecontainer
---@field GetSpellBlockContainer fun() : df_framecontainer
---@field GetTargetScrollContainer fun() : df_framecontainer
---@field OnProfileChange fun()
---@field UpdateHeadersSettings fun(containerType: string)
---@field BuildHeaderTable fun(containerType: string) : {name: string, width: number, text: string, align: string}[]
---@field SelectSpellBar fun(spellBar: breakdownspellbar)
---@field UnSelectSpellBar fun()
---@field GetSelectedSpellBar fun() : breakdownspellbar
---@field HasSelectedSpellBar fun() : boolean
---@field OnShownTab fun()
---@field OnCreateTabCallback fun(tabButton: button, tabFrame: frame)
---@field CreateSpellBlock fun(spellBlockContainer: breakdownspellblockframe, index: number) : breakdownspellblock
---@field CreateSpellBlockContainer fun(tabFrame: tabframe) : breakdownspellblockframe
---@field UpdateShownSpellBlock fun()
---@field CreateTargetContainer fun(tabFrame: tabframe) : breakdowntargetscrollframe
---@field CreateGenericContainers fun(tabFrame: tabframe) : breakdowngenericscrollframe, breakdowngenericscrollframe
---@field CreateSpellScrollContainer fun(tabFrame: tabframe) : breakdownspellscrollframe
---@field CreateTargetBar fun(self: breakdowntargetscrollframe, index: number) : breakdowntargetbar
---@field CreateSpellBar fun(self: breakdownspellscrollframe, index: number) : breakdownspellbar

---@class timemachine : table
---@field Ticker fun() runs each second and check if actors are performing damage and healing actions, if the actor isn't, stop the activity time of that actor
---@field Start fun() start the time machine, called once from the start.lua
---@field Cleanup fun() check for actors with __destroyed flag and remove them from the time machine
---@field Restart fun() reset all data inside the time machine
---@field AddActor fun(actor: actor) add the actor to the time machine
---@field RemoveActor fun(actor: actor) remove the actor from the time machine
---@field StopTime fun(actor: actor) stop the time of the actor
---@field SetOrGetPauseState fun(actor: actor, bPause: boolean|nil) : boolean|nil set or get the pause state of the actor, if bPause is nil, then it will return the current pause state

---@class details222 : table
---@field TimeMachine timemachine


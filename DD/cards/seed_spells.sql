-- ============================================================
-- Shadow of the Wolf — SRD 5.1 Spells (Levels 1–4)
-- All content from the Systems Reference Document 5.1
-- Licensed under Creative Commons Attribution 4.0
-- ============================================================

-- ── LEVEL 1 SPELLS ──

INSERT INTO spells (name, level, school, casting_time, range, components, duration, concentration, ritual, description, higher_levels, classes) VALUES

('Alarm', 1, 'Abjuration', '1 minute', '30 feet', 'V, S, M (a tiny bell and a piece of fine silver wire)', '8 hours', FALSE, TRUE,
 'You set an alarm against unwanted intrusion. Choose a door, a window, or an area within range that is no larger than a 20-foot cube. Until the spell ends, an alarm alerts you whenever a Tiny or larger creature touches or enters the warded area. When you cast the spell, you can designate creatures that won''t set off the alarm. You also choose whether the alarm is mental or audible. A mental alarm alerts you with a ping in your mind if you are within 1 mile of the warded area. This ping awakens you if you are sleeping. An audible alarm produces the sound of a hand bell for 10 seconds within 60 feet.',
 NULL, '{"Ranger","Wizard"}'),

('Burning Hands', 1, 'Evocation', '1 action', 'Self (15-foot cone)', 'V, S', 'Instantaneous', FALSE, FALSE,
 'As you hold your hands with thumbs touching and fingers spread, a thin sheet of flames shoots forth from your outstretched fingertips. Each creature in a 15-foot cone must make a Dexterity saving throw. A creature takes 3d6 fire damage on a failed save, or half as much damage on a successful one. The fire ignites any flammable objects in the area that aren''t being worn or carried.',
 'When you cast this spell using a spell slot of 2nd level or higher, the damage increases by 1d6 for each slot level above 1st.', '{"Sorcerer","Wizard"}'),

('Charm Person', 1, 'Enchantment', '1 action', '30 feet', 'V, S', '1 hour', FALSE, FALSE,
 'You attempt to charm a humanoid you can see within range. It must make a Wisdom saving throw, and does so with advantage if you or your companions are fighting it. If it fails the saving throw, it is charmed by you until the spell ends or until you or your companions do anything harmful to it. The charmed creature regards you as a friendly acquaintance. When the spell ends, the creature knows it was charmed by you.',
 'When you cast this spell using a spell slot of 2nd level or higher, you can target one additional creature for each slot level above 1st.', '{"Bard","Druid","Sorcerer","Warlock","Wizard"}'),

('Color Spray', 1, 'Illusion', '1 action', 'Self (15-foot cone)', 'V, S, M (a pinch of powder or sand colored red, yellow, and blue)', 'Instantaneous', FALSE, FALSE,
 'A dazzling array of flashing, colored light springs from your hand. Roll 6d10; the total is how many hit points of creatures this spell can affect. Creatures in a 15-foot cone originating from you are affected in ascending order of their current hit points. Each creature affected by this spell is blinded until the end of your next turn.',
 'When you cast this spell using a spell slot of 2nd level or higher, roll an additional 2d10 for each slot level above 1st.', '{"Sorcerer","Wizard"}'),

('Comprehend Languages', 1, 'Divination', '1 action', 'Self', 'V, S, M (a pinch of soot and salt)', '1 hour', FALSE, TRUE,
 'For the duration, you understand the literal meaning of any spoken language that you hear. You also understand any written language that you see, but you must be touching the surface on which the words are written. It takes about 1 minute to read one page of text. This spell doesn''t decode secret messages in a text or a glyph that isn''t part of a written language.',
 NULL, '{"Bard","Sorcerer","Warlock","Wizard"}'),

('Cure Wounds', 1, 'Evocation', '1 action', 'Touch', 'V, S', 'Instantaneous', FALSE, FALSE,
 'A creature you touch regains a number of hit points equal to 1d8 + your spellcasting ability modifier. This spell has no effect on undead or constructs.',
 'When you cast this spell using a spell slot of 2nd level or higher, the healing increases by 1d8 for each slot level above 1st.', '{"Bard","Cleric","Druid","Paladin","Ranger"}'),

('Detect Magic', 1, 'Divination', '1 action', '30 feet', 'V, S', 'Concentration, up to 10 minutes', TRUE, TRUE,
 'For the duration, you sense the presence of magic within 30 feet of you. If you sense magic in this way, you can use your action to see a faint aura around any visible creature or object in the area that bears magic, and you learn its school of magic, if any. The spell can penetrate most barriers, but it is blocked by 1 foot of stone, 1 inch of common metal, a thin sheet of lead, or 3 feet of wood or dirt.',
 NULL, '{"Bard","Cleric","Druid","Paladin","Ranger","Sorcerer","Wizard"}'),

('Disguise Self', 1, 'Illusion', '1 action', 'Self', 'V, S', '1 hour', FALSE, FALSE,
 'You make yourself—including your clothing, armor, weapons, and other belongings on your person—look different until the spell ends or until you use your action to dismiss it. You can seem 1 foot shorter or taller and can appear thin, fat, or in between. You can''t change your body type, so you must adopt a form that has the same basic arrangement of limbs. Otherwise, the extent of the illusion is up to you. To discern that you are disguised, a creature can use its action to inspect your appearance and must succeed on an Intelligence (Investigation) check against your spell save DC.',
 NULL, '{"Bard","Sorcerer","Wizard"}'),

('Expeditious Retreat', 1, 'Transmutation', '1 bonus action', 'Self', 'V, S', 'Concentration, up to 10 minutes', TRUE, FALSE,
 'This spell allows you to move at an incredible pace. When you cast this spell, and then as a bonus action on each of your turns until the spell ends, you can take the Dash action.',
 NULL, '{"Sorcerer","Warlock","Wizard"}'),

('Faerie Fire', 1, 'Evocation', '1 action', '60 feet', 'V', 'Concentration, up to 1 minute', TRUE, FALSE,
 'Each object in a 20-foot cube within range is outlined in blue, green, or violet light (your choice). Any creature in the area when the spell is cast is also outlined in light if it fails a Dexterity saving throw. For the duration, objects and affected creatures shed dim light in a 10-foot radius. Any attack roll against an affected creature or object has advantage if the attacker can see it, and the affected creature or object can''t benefit from being invisible.',
 NULL, '{"Bard","Druid"}'),

('False Life', 1, 'Necromancy', '1 action', 'Self', 'V, S, M (a small amount of alcohol or distilled spirits)', '1 hour', FALSE, FALSE,
 'Bolstering yourself with a necromantic facsimile of life, you gain 1d4 + 4 temporary hit points for the duration.',
 'When you cast this spell using a spell slot of 2nd level or higher, you gain 5 additional temporary hit points for each slot level above 1st.', '{"Sorcerer","Wizard"}'),

('Feather Fall', 1, 'Transmutation', '1 reaction, which you take when you or a creature within 60 feet of you falls', '60 feet', 'V, M (a small feather or piece of down)', '1 minute', FALSE, FALSE,
 'Choose up to five falling creatures within range. A falling creature''s rate of descent slows to 60 feet per round until the spell ends. If the creature lands before the spell ends, it takes no falling damage and can land on its feet, and the spell ends for that creature.',
 NULL, '{"Bard","Sorcerer","Wizard"}'),

('Fog Cloud', 1, 'Conjuration', '1 action', '120 feet', 'V, S', 'Concentration, up to 1 hour', TRUE, FALSE,
 'You create a 20-foot-radius sphere of fog centered on a point within range. The sphere spreads around corners, and its area is heavily obscured. It lasts for the duration or until a wind of moderate or greater speed (at least 10 miles per hour) disperses it.',
 'When you cast this spell using a spell slot of 2nd level or higher, the radius of the fog increases by 20 feet for each slot level above 1st.', '{"Druid","Ranger","Sorcerer","Wizard"}'),

('Goodberry', 1, 'Transmutation', '1 action', 'Touch', 'V, S, M (a sprig of mistletoe)', 'Instantaneous', FALSE, FALSE,
 'Up to ten berries appear in your hand and are infused with magic for the duration. A creature can use its action to eat one berry. Eating a berry restores 1 hit point, and the berry provides enough nourishment to sustain a creature for one day. The berries lose their potency if they have not been consumed within 24 hours of the casting of this spell.',
 NULL, '{"Druid","Ranger"}'),

('Grease', 1, 'Conjuration', '1 action', '60 feet', 'V, S, M (a bit of pork rind or butter)', '1 minute', FALSE, FALSE,
 'Slick grease covers the ground in a 10-foot square centered on a point within range and turns it into difficult terrain for the duration. When the grease appears, each creature standing in its area must succeed on a Dexterity saving throw or fall prone. A creature that enters the area or ends its turn there must also succeed on a Dexterity saving throw or fall prone.',
 NULL, '{"Wizard"}'),

('Guiding Bolt', 1, 'Evocation', '1 action', '120 feet', 'V, S', '1 round', FALSE, FALSE,
 'A flash of light streaks toward a creature of your choice within range. Make a ranged spell attack against the target. On a hit, the target takes 4d6 radiant damage, and the next attack roll made against this target before the end of your next turn has advantage, thanks to the mystical dim light glittering on the target until then.',
 'When you cast this spell using a spell slot of 2nd level or higher, the damage increases by 1d6 for each slot level above 1st.', '{"Cleric"}'),

('Healing Word', 1, 'Evocation', '1 bonus action', '60 feet', 'V', 'Instantaneous', FALSE, FALSE,
 'A creature of your choice that you can see within range regains hit points equal to 1d4 + your spellcasting ability modifier. This spell has no effect on undead or constructs.',
 'When you cast this spell using a spell slot of 2nd level or higher, the healing increases by 1d4 for each slot level above 1st.', '{"Bard","Cleric","Druid"}'),

('Heroism', 1, 'Enchantment', '1 action', 'Touch', 'V, S', 'Concentration, up to 1 minute', TRUE, FALSE,
 'A willing creature you touch is imbued with bravery. Until the spell ends, the creature is immune to being frightened and gains temporary hit points equal to your spellcasting ability modifier at the start of each of its turns. When the spell ends, the target loses any remaining temporary hit points from this spell.',
 NULL, '{"Bard","Paladin"}'),

('Hideous Laughter', 1, 'Enchantment', '1 action', '30 feet', 'V, S, M (tiny tarts and a feather that is waved in the air)', 'Concentration, up to 1 minute', TRUE, FALSE,
 'A creature of your choice that you can see within range perceives everything as hilariously funny and falls into fits of laughter if this spell affects it. The target must succeed on a Wisdom saving throw or fall prone, becoming incapacitated and unable to stand up for the duration. A creature with an Intelligence score of 4 or less isn''t affected. At the end of each of its turns, and each time it takes damage, the target can make another Wisdom saving throw.',
 NULL, '{"Bard","Wizard"}'),

('Hunter''s Mark', 1, 'Divination', '1 bonus action', '90 feet', 'V', 'Concentration, up to 1 hour', TRUE, FALSE,
 'You choose a creature you can see within range and mystically mark it as your quarry. Until the spell ends, you deal an extra 1d6 damage to the target whenever you hit it with a weapon attack, and you have advantage on any Wisdom (Perception) or Wisdom (Survival) check you make to find it. If the target drops to 0 hit points before this spell ends, you can use a bonus action on a subsequent turn to mark a new creature.',
 'When you cast this spell using a spell slot of 3rd or 4th level, you can maintain concentration for up to 8 hours.', '{"Ranger"}'),

('Identify', 1, 'Divination', '1 minute', 'Touch', 'V, S, M (a pearl worth at least 100 gp and an owl feather)', 'Instantaneous', FALSE, TRUE,
 'You choose one object that you must touch throughout the casting of the spell. If it is a magic item or some other magic-imbued object, you learn its properties and how to use them, whether it requires attunement, and how many charges it has, if any. You learn whether any spells are affecting the item and what they are. If the item was created by a spell, you learn which spell created it. If you instead touch a creature, you learn what spells, if any, are currently affecting it.',
 NULL, '{"Bard","Wizard"}'),

('Inflict Wounds', 1, 'Necromancy', '1 action', 'Touch', 'V, S', 'Instantaneous', FALSE, FALSE,
 'Make a melee spell attack against a creature you can reach. On a hit, the target takes 3d10 necrotic damage.',
 'When you cast this spell using a spell slot of 2nd level or higher, the damage increases by 1d10 for each slot level above 1st.', '{"Cleric"}'),

('Jump', 1, 'Transmutation', '1 action', 'Touch', 'V, S, M (a grasshopper''s hind leg)', '1 minute', FALSE, FALSE,
 'You touch a creature. The creature''s jump distance is tripled until the spell ends.',
 NULL, '{"Druid","Ranger","Sorcerer","Wizard"}'),

('Longstrider', 1, 'Transmutation', '1 action', 'Touch', 'V, S, M (a pinch of dirt)', '1 hour', FALSE, FALSE,
 'You touch a creature. The target''s speed increases by 10 feet until the spell ends.',
 'When you cast this spell using a spell slot of 2nd level or higher, you can target one additional creature for each slot level above 1st.', '{"Bard","Druid","Ranger","Wizard"}'),

('Mage Armor', 1, 'Abjuration', '1 action', 'Touch', 'V, S, M (a piece of cured leather)', '8 hours', FALSE, FALSE,
 'You touch a willing creature who isn''t wearing armor, and a protective magical force surrounds it until the spell ends. The target''s base AC becomes 13 + its Dexterity modifier. The spell ends if the target dons armor or if you dismiss the spell as an action.',
 NULL, '{"Sorcerer","Wizard"}'),

('Magic Missile', 1, 'Evocation', '1 action', '120 feet', 'V, S', 'Instantaneous', FALSE, FALSE,
 'You create three glowing darts of magical force. Each dart hits a creature of your choice that you can see within range. A dart deals 1d4 + 1 force damage to its target. The darts all strike simultaneously, and you can direct them to hit one creature or several.',
 'When you cast this spell using a spell slot of 2nd level or higher, the spell creates one more dart for each slot level above 1st.', '{"Sorcerer","Wizard"}'),

('Protection from Evil and Good', 1, 'Abjuration', '1 action', 'Touch', 'V, S, M (holy water or powdered silver and iron, which the spell consumes)', 'Concentration, up to 10 minutes', TRUE, FALSE,
 'Until the spell ends, one willing creature you touch is protected against certain types of creatures: aberrations, celestials, elementals, fey, fiends, and undead. The protection grants several benefits. Creatures of those types have disadvantage on attack rolls against the target. The target also can''t be charmed, frightened, or possessed by them. If the target is already charmed, frightened, or possessed, the target has advantage on any new saving throw against the relevant effect.',
 NULL, '{"Cleric","Paladin","Warlock","Wizard"}'),

('Sanctuary', 1, 'Abjuration', '1 bonus action', '30 feet', 'V, S, M (a small silver mirror)', '1 minute', FALSE, FALSE,
 'You ward a creature within range against attack. Until the spell ends, any creature who targets the warded creature with an attack or a harmful spell must first make a Wisdom saving throw. On a failed save, the creature must choose a new target or lose the attack or spell. This spell doesn''t protect the warded creature from area effects. If the warded creature makes an attack, casts a spell that affects an enemy, or deals damage to another creature, this spell ends.',
 NULL, '{"Cleric"}'),

('Shield', 1, 'Abjuration', '1 reaction, which you take when you are hit by an attack or targeted by the magic missile spell', 'Self', 'V, S', '1 round', FALSE, FALSE,
 'An invisible barrier of magical force appears and protects you. Until the start of your next turn, you have a +5 bonus to AC, including against the triggering attack, and you take no damage from magic missile.',
 NULL, '{"Sorcerer","Wizard"}'),

('Shield of Faith', 1, 'Abjuration', '1 bonus action', '60 feet', 'V, S, M (a small parchment with a bit of holy text written on it)', 'Concentration, up to 10 minutes', TRUE, FALSE,
 'A shimmering field appears and surrounds a creature of your choice within range, granting it a +2 bonus to AC for the duration.',
 NULL, '{"Cleric","Paladin"}'),

('Silent Image', 1, 'Illusion', '1 action', '60 feet', 'V, S, M (a bit of fleece)', 'Concentration, up to 10 minutes', TRUE, FALSE,
 'You create the image of an object, a creature, or some other visible phenomenon that is no larger than a 15-foot cube. The image appears at a spot within range and lasts for the duration. The image is purely visual; it isn''t accompanied by sound, smell, or other sensory effects. You can use your action to cause the image to move to any spot within range. As the image changes location, you can alter its appearance so that its movements appear natural for the image. Physical interaction with the image reveals it to be an illusion, because things can pass through it. A creature that uses its action to examine the image can determine that it is an illusion with a successful Intelligence (Investigation) check against your spell save DC.',
 NULL, '{"Bard","Sorcerer","Wizard"}'),

('Sleep', 1, 'Enchantment', '1 action', '90 feet', 'V, S, M (a pinch of fine sand, rose petals, or a cricket)', '1 minute', FALSE, FALSE,
 'This spell sends creatures into a magical slumber. Roll 5d8; the total is how many hit points of creatures this spell can affect. Creatures within 20 feet of a point you choose within range are affected in ascending order of their current hit points. Each creature affected by this spell falls unconscious until the spell ends, the sleeper takes damage, or someone uses an action to shake or slap the sleeper awake. Undead and creatures immune to being charmed aren''t affected by this spell.',
 'When you cast this spell using a spell slot of 2nd level or higher, roll an additional 2d8 for each slot level above 1st.', '{"Bard","Sorcerer","Wizard"}'),

('Speak with Animals', 1, 'Divination', '1 action', 'Self', 'V, S', '10 minutes', FALSE, TRUE,
 'You gain the ability to comprehend and verbally communicate with beasts for the duration. The knowledge and awareness of many beasts is limited by their intelligence, but at minimum, beasts can give you information about nearby locations and monsters, including whatever they can perceive or have perceived within the past day.',
 NULL, '{"Bard","Druid","Ranger"}'),

('Thunderwave', 1, 'Evocation', '1 action', 'Self (15-foot cube)', 'V, S', 'Instantaneous', FALSE, FALSE,
 'A wave of thunderous force sweeps out from you. Each creature in a 15-foot cube originating from you must make a Constitution saving throw. On a failed save, a creature takes 2d8 thunder damage and is pushed 10 feet away from you. On a successful save, the creature takes half as much damage and isn''t pushed. In addition, unsecured objects that are completely within the area of effect are automatically pushed 10 feet away from you by the spell''s effect, and the spell emits a thunderous boom audible out to 300 feet.',
 'When you cast this spell using a spell slot of 2nd level or higher, the damage increases by 1d8 for each slot level above 1st.', '{"Bard","Druid","Sorcerer","Wizard"}'),

('Unseen Servant', 1, 'Conjuration', '1 action', '60 feet', 'V, S, M (a piece of string and a bit of wood)', '1 hour', FALSE, TRUE,
 'This spell creates an invisible, mindless, shapeless, Medium force that performs simple tasks at your command until the spell ends. The servant springs into existence in an unoccupied space on the ground within range. It has AC 10, 1 hit point, and a Strength of 2, and it can''t attack. If it drops to 0 hit points, the spell ends. Once on each of your turns as a bonus action, you can mentally command the servant to move up to 15 feet and interact with an object. The servant can perform simple tasks that a human servant could do.',
 NULL, '{"Bard","Warlock","Wizard"}'),

('Entangle', 1, 'Conjuration', '1 action', '90 feet', 'V, S', 'Concentration, up to 1 minute', TRUE, FALSE,
 'Grasping weeds and vines sprout from the ground in a 20-foot square starting from a point within range. For the duration, these plants turn the ground in the area into difficult terrain. A creature in the area when you cast the spell must succeed on a Strength saving throw or be restrained by the entangling plants until the spell ends. A creature restrained by the plants can use its action to make a Strength check against your spell save DC. On a success, it frees itself.',
 NULL, '{"Druid"}'),

('Create or Destroy Water', 1, 'Transmutation', '1 action', '30 feet', 'V, S, M (a drop of water if creating water or a few grains of sand if destroying it)', 'Instantaneous', FALSE, FALSE,
 'You either create or destroy water. Create Water: You create up to 10 gallons of clean water within range in an open container, or the water falls as rain in a 30-foot cube within range, extinguishing exposed flames. Destroy Water: You destroy up to 10 gallons of water in an open container, or you destroy fog in a 30-foot cube within range.',
 'When you cast this spell using a spell slot of 2nd level or higher, you create or destroy 10 additional gallons of water, or the size of the cube increases by 5 feet, for each slot level above 1st.', '{"Cleric","Druid"}'),

('Detect Evil and Good', 1, 'Divination', '1 action', 'Self', 'V, S', 'Concentration, up to 10 minutes', TRUE, FALSE,
 'For the duration, you know if there is an aberration, celestial, elemental, fey, fiend, or undead within 30 feet of you, as well as where the creature is located. Similarly, you know if there is a place or object within 30 feet of you that has been magically consecrated or desecrated. The spell can penetrate most barriers, but it is blocked by 1 foot of stone, 1 inch of common metal, a thin sheet of lead, or 3 feet of wood or dirt.',
 NULL, '{"Cleric","Paladin"}'),

('Detect Poison and Disease', 1, 'Divination', '1 action', 'Self', 'V, S, M (a yew leaf)', 'Concentration, up to 10 minutes', TRUE, TRUE,
 'For the duration, you can sense the presence and location of poisons, poisonous creatures, and diseases within 30 feet of you. You also identify the kind of poison, poisonous creature, or disease in each case. The spell can penetrate most barriers, but it is blocked by 1 foot of stone, 1 inch of common metal, a thin sheet of lead, or 3 feet of wood or dirt.',
 NULL, '{"Cleric","Druid","Paladin","Ranger"}'),

('Bless', 1, 'Enchantment', '1 action', '30 feet', 'V, S, M (a sprinkling of holy water)', 'Concentration, up to 1 minute', TRUE, FALSE,
 'You bless up to three creatures of your choice within range. Whenever a target makes an attack roll or a saving throw before the spell ends, the target can roll a d4 and add the number rolled to the attack roll or saving throw.',
 'When you cast this spell using a spell slot of 2nd level or higher, you can target one additional creature for each slot level above 1st.', '{"Cleric","Paladin"}'),

('Command', 1, 'Enchantment', '1 action', '60 feet', 'V', '1 round', FALSE, FALSE,
 'You speak a one-word command to a creature you can see within range. The target must succeed on a Wisdom saving throw or follow the command on its next turn. The spell has no effect if the target is undead, if it doesn''t understand your language, or if your command is directly harmful to it. Typical commands include Approach, Drop, Flee, Grovel, and Halt.',
 'When you cast this spell using a spell slot of 2nd level or higher, you can affect one additional creature for each slot level above 1st.', '{"Cleric","Paladin"}'),

('Divine Favor', 1, 'Evocation', '1 bonus action', 'Self', 'V, S', 'Concentration, up to 1 minute', TRUE, FALSE,
 'Your prayer empowers you with divine radiance. Until the spell ends, your weapon attacks deal an extra 1d4 radiant damage on a hit.',
 NULL, '{"Paladin"}'),

('Bane', 1, 'Enchantment', '1 action', '30 feet', 'V, S, M (a drop of blood)', 'Concentration, up to 1 minute', TRUE, FALSE,
 'Up to three creatures of your choice that you can see within range must make Charisma saving throws. Whenever a target that fails this saving throw makes an attack roll or a saving throw before the spell ends, the target must roll a d4 and subtract the number rolled from the attack roll or saving throw.',
 'When you cast this spell using a spell slot of 2nd level or higher, you can target one additional creature for each slot level above 1st.', '{"Bard","Cleric"}'),

('Thunderous Smite', 1, 'Evocation', '1 bonus action', 'Self', 'V', 'Concentration, up to 1 minute', TRUE, FALSE,
 'The first time you hit with a melee weapon attack during this spell''s duration, your weapon rings with thunder that is audible within 300 feet of you, and the attack deals an extra 2d6 thunder damage to the target. Additionally, if the target is a creature, it must succeed on a Strength saving throw or be pushed 10 feet away from you and knocked prone.',
 NULL, '{"Paladin"}'),

('Wrathful Smite', 1, 'Evocation', '1 bonus action', 'Self', 'V', 'Concentration, up to 1 minute', TRUE, FALSE,
 'The next time you hit with a melee weapon attack during this spell''s duration, your attack deals an extra 1d6 psychic damage. Additionally, if the target is a creature, it must make a Wisdom saving throw or be frightened of you until the spell ends. As an action, the creature can make a Wisdom check against your spell save DC to steel its resolve and end this spell.',
 NULL, '{"Paladin"}'),

('Searing Smite', 1, 'Evocation', '1 bonus action', 'Self', 'V', 'Concentration, up to 1 minute', TRUE, FALSE,
 'The next time you hit a creature with a melee weapon attack during the spell''s duration, your weapon flares with white-hot intensity, and the attack deals an extra 1d6 fire damage to the target and causes the target to ignite in flames. At the start of each of its turns until the spell ends, the target must make a Constitution saving throw. On a failed save, it takes 1d6 fire damage. On a successful save, the spell ends. If the target or a creature within 5 feet of it uses an action to put out the flames, or if some other effect douses the flames, the spell ends.',
 NULL, '{"Paladin"}'),

('Animal Friendship', 1, 'Enchantment', '1 action', '30 feet', 'V, S, M (a morsel of food)', '24 hours', FALSE, FALSE,
 'This spell lets you convince a beast that you mean it no harm. Choose a beast that you can see within range. It must see and hear you. If the beast''s Intelligence is 4 or higher, the spell fails. Otherwise, the beast must succeed on a Wisdom saving throw or be charmed by you for the spell''s duration. If you or one of your companions harms the target, the spell ends.',
 'When you cast this spell using a spell slot of 2nd level or higher, you can affect one additional beast for each slot level above 1st.', '{"Bard","Druid","Ranger"}'),

('Purify Food and Drink', 1, 'Transmutation', '1 action', '10 feet', 'V, S', 'Instantaneous', FALSE, TRUE,
 'All nonmagical food and drink within a 5-foot-radius sphere centered on a point of your choice within range is purified and rendered free of poison and disease.',
 NULL, '{"Cleric","Druid","Paladin"}');


-- ── LEVEL 2 SPELLS ──

INSERT INTO spells (name, level, school, casting_time, range, components, duration, concentration, ritual, description, higher_levels, classes) VALUES

('Aid', 2, 'Abjuration', '1 action', '30 feet', 'V, S, M (a tiny strip of white cloth)', '8 hours', FALSE, FALSE,
 'Your spell bolsters your allies with toughness and resolve. Choose up to three creatures within range. Each target''s hit point maximum and current hit points increase by 5 for the duration.',
 'When you cast this spell using a spell slot of 3rd level or higher, a target''s hit points increase by an additional 5 for each slot level above 2nd.', '{"Cleric","Paladin"}'),

('Alter Self', 2, 'Transmutation', '1 action', 'Self', 'V, S', 'Concentration, up to 1 hour', TRUE, FALSE,
 'You assume a different form. When you cast the spell, choose one of the following options: Aquatic Adaptation (you adapt your body to an aquatic environment, sprouting gills and growing webbing), Change Appearance (you transform your appearance, choosing your height, weight, facial features, sound of your voice, hair length, coloration, and distinguishing characteristics), or Natural Weapons (you grow claws, fangs, spines, horns, or a different natural weapon of your choice that deals 1d6 bludgeoning, piercing, or slashing damage, is magical, and you have a +1 bonus to attack and damage rolls).',
 NULL, '{"Sorcerer","Wizard"}'),

('Arcane Lock', 2, 'Abjuration', '1 action', 'Touch', 'V, S, M (gold dust worth at least 25 gp, which the spell consumes)', 'Until dispelled', FALSE, FALSE,
 'You touch a closed door, window, gate, chest, or other entryway, and it becomes locked for the duration. You and the creatures you designate when you cast this spell can open the object normally. You can also set a password that, when spoken within 5 feet of the object, suppresses this spell for 1 minute. Otherwise, it is impassable until it is broken or the spell is dispelled or suppressed. While affected by this spell, the object is more difficult to break or force open; the DC to break it or pick any locks on it increases by 10.',
 NULL, '{"Wizard"}'),

('Augury', 2, 'Divination', '1 minute', 'Self', 'V, S, M (specially marked sticks, bones, or similar tokens worth at least 25 gp)', 'Instantaneous', FALSE, TRUE,
 'By casting gem-inlaid sticks, rolling dragon bones, laying out ornate cards, or employing some other divining tool, you receive an omen from an otherworldly entity about the results of a specific course of action that you plan to take within the next 30 minutes. The DM chooses from weal, woe, weal and woe, or nothing.',
 NULL, '{"Cleric"}'),

('Barkskin', 2, 'Transmutation', '1 action', 'Touch', 'V, S, M (a handful of oak bark)', 'Concentration, up to 1 hour', TRUE, FALSE,
 'You touch a willing creature. Until the spell ends, the target''s skin has a rough, bark-like appearance, and the target''s AC can''t be less than 16, regardless of what kind of armor it is wearing.',
 NULL, '{"Druid","Ranger"}'),

('Blindness/Deafness', 2, 'Necromancy', '1 action', '30 feet', 'V', '1 minute', FALSE, FALSE,
 'You can blind or deafen a foe. Choose one creature that you can see within range to make a Constitution saving throw. If it fails, the target is either blinded or deafened (your choice) for the duration. At the end of each of its turns, the target can make a Constitution saving throw. On a success, the spell ends.',
 'When you cast this spell using a spell slot of 3rd level or higher, you can target one additional creature for each slot level above 2nd.', '{"Bard","Cleric","Sorcerer","Wizard"}'),

('Blur', 2, 'Illusion', '1 action', 'Self', 'V', 'Concentration, up to 1 minute', TRUE, FALSE,
 'Your body becomes blurred, shifting and wavering to all who can see you. For the duration, any creature has disadvantage on attack rolls against you. An attacker is immune to this effect if it doesn''t rely on sight, as with blindsight, or can see through illusions, as with truesight.',
 NULL, '{"Sorcerer","Wizard"}'),

('Calm Emotions', 2, 'Enchantment', '1 action', '60 feet', 'V, S', 'Concentration, up to 1 minute', TRUE, FALSE,
 'You attempt to suppress strong emotions in a group of people. Each humanoid in a 20-foot-radius sphere centered on a point you choose within range must make a Charisma saving throw; a creature can choose to fail this saving throw if it wishes. If a creature fails its saving throw, choose one of two effects: you can suppress any effect causing a target to be charmed or frightened, or you can make a target indifferent about creatures of your choice that it is hostile toward.',
 NULL, '{"Bard","Cleric"}'),

('Continual Flame', 2, 'Evocation', '1 action', 'Touch', 'V, S, M (ruby dust worth 50 gp, which the spell consumes)', 'Until dispelled', FALSE, FALSE,
 'A flame, equivalent in brightness to a torch, springs forth from an object that you touch. The effect looks like a regular flame, but it creates no heat and doesn''t use oxygen. A continual flame can be covered or hidden but not smothered or quenched.',
 NULL, '{"Cleric","Wizard"}'),

('Darkness', 2, 'Evocation', '1 action', '60 feet', 'V, M (bat fur and a drop of pitch or piece of coal)', 'Concentration, up to 10 minutes', TRUE, FALSE,
 'Magical darkness spreads from a point you choose within range to fill a 15-foot-radius sphere for the duration. The darkness spreads around corners. A creature with darkvision can''t see through this darkness, and nonmagical light can''t illuminate it. If the point you choose is on an object you are holding or one that isn''t being worn or carried, the darkness emanates from the object and moves with it. Completely covering the source of the darkness with an opaque object blocks the darkness.',
 NULL, '{"Sorcerer","Warlock","Wizard"}'),

('Darkvision', 2, 'Transmutation', '1 action', 'Touch', 'V, S, M (either a pinch of dried carrot or an agate)', '8 hours', FALSE, FALSE,
 'You touch a willing creature to grant it the ability to see in the dark. For the duration, that creature has darkvision out to a range of 60 feet.',
 NULL, '{"Druid","Ranger","Sorcerer","Wizard"}'),

('Detect Thoughts', 2, 'Divination', '1 action', 'Self', 'V, S, M (a copper piece)', 'Concentration, up to 1 minute', TRUE, FALSE,
 'For the duration, you can read the thoughts of certain creatures. When you cast the spell and as your action on each turn until the spell ends, you can focus your mind on any one creature that you can see within 30 feet of you. If the creature you choose has an Intelligence of 3 or lower or doesn''t speak any language, the creature is unaffected. You initially learn the surface thoughts of the creature. As an action, you can either shift your attention to another creature or attempt to probe deeper. The target must make a Wisdom saving throw to resist the deeper probe.',
 NULL, '{"Bard","Sorcerer","Wizard"}'),

('Enhance Ability', 2, 'Transmutation', '1 action', 'Touch', 'V, S, M (fur or a feather from a beast)', 'Concentration, up to 1 hour', TRUE, FALSE,
 'You touch a creature and bestow upon it a magical enhancement. Choose one of the following effects: Bear''s Endurance (advantage on Constitution checks, 2d6 temporary hp), Bull''s Strength (advantage on Strength checks, carrying capacity doubles), Cat''s Grace (advantage on Dexterity checks, no falling damage from 20 feet or less), Eagle''s Splendor (advantage on Charisma checks), Fox''s Cunning (advantage on Intelligence checks), or Owl''s Wisdom (advantage on Wisdom checks).',
 'When you cast this spell using a spell slot of 3rd level or higher, you can target one additional creature for each slot level above 2nd.', '{"Bard","Cleric","Druid","Sorcerer"}'),

('Enlarge/Reduce', 2, 'Transmutation', '1 action', '30 feet', 'V, S, M (a pinch of powdered iron)', 'Concentration, up to 1 minute', TRUE, FALSE,
 'You cause a creature or an object you can see within range to grow larger or smaller for the duration. Choose either the enlarge or reduce effect. Enlarge: The target''s size doubles in all dimensions, and its weight is multiplied by eight, growing one size category. Its weapons also grow; while enlarged, the target''s attacks with them deal 1d4 extra damage. Reduce: The target''s size is halved in all dimensions, and its weight is reduced to one-eighth; its weapons shrink and deal 1d4 less damage (minimum 1).',
 NULL, '{"Sorcerer","Wizard"}'),

('Find Steed', 2, 'Conjuration', '10 minutes', '30 feet', 'V, S', 'Instantaneous', FALSE, FALSE,
 'You summon a spirit that assumes the form of an unusually intelligent, strong, and loyal steed, creating a long-lasting bond with it. Appearing in an unoccupied space within range, the steed takes on a form that you choose: a warhorse, a pony, a camel, an elk, or a mastiff. The steed has the statistics of the chosen form, though it is a celestial, fey, or fiend instead of its normal type. While your steed is within 1 mile of you, you can communicate with it telepathically.',
 NULL, '{"Paladin"}'),

('Flame Blade', 2, 'Evocation', '1 bonus action', 'Self', 'V, S, M (leaf of sumac)', 'Concentration, up to 10 minutes', TRUE, FALSE,
 'You evoke a fiery blade in your free hand. The blade is similar in size and shape to a scimitar, and it lasts for the duration. You can use your action to make a melee spell attack with the fiery blade. On a hit, the target takes 3d6 fire damage. The flaming blade sheds bright light in a 10-foot radius and dim light for an additional 10 feet.',
 'When you cast this spell using a spell slot of 4th level or higher, the damage increases by 1d6 for every two slot levels above 2nd.', '{"Druid"}'),

('Flaming Sphere', 2, 'Conjuration', '1 action', '60 feet', 'V, S, M (a bit of tallow, a pinch of brimstone, and a dusting of powdered iron)', 'Concentration, up to 1 minute', TRUE, FALSE,
 'A 5-foot-diameter sphere of fire appears in an unoccupied space of your choice within range and lasts for the duration. Any creature that ends its turn within 5 feet of the sphere must make a Dexterity saving throw, taking 2d6 fire damage on a failed save, or half as much on a success. As a bonus action, you can move the sphere up to 30 feet. It ignites flammable objects not being worn or carried, and it sheds bright light in a 20-foot radius.',
 'When you cast this spell using a spell slot of 3rd level or higher, the damage increases by 1d6 for each slot level above 2nd.', '{"Druid","Wizard"}'),

('Gentle Repose', 2, 'Necromancy', '1 action', 'Touch', 'V, S, M (a pinch of salt and one copper piece per eye)', '10 days', FALSE, TRUE,
 'You touch a corpse or other remains. For the duration, the target is protected from decay and can''t become undead. The spell also effectively extends the time limit on raising the target from the dead, since days spent under the influence of this spell don''t count against the time limit of spells such as raise dead.',
 NULL, '{"Cleric","Wizard"}'),

('Gust of Wind', 2, 'Evocation', '1 action', 'Self (60-foot line)', 'V, S, M (a legume seed)', 'Concentration, up to 1 minute', TRUE, FALSE,
 'A line of strong wind 60 feet long and 10 feet wide blasts from you in a direction you choose for the spell''s duration. Each creature that starts its turn in the line must succeed on a Strength saving throw or be pushed 15 feet away from you in a direction following the line. Any creature in the line must spend 2 feet of movement for every 1 foot it moves when moving closer to you. The gust disperses gas or vapor, and it extinguishes candles, torches, and similar unprotected flames in the area.',
 NULL, '{"Druid","Sorcerer","Wizard"}'),

('Heat Metal', 2, 'Transmutation', '1 action', '60 feet', 'V, S, M (a piece of iron and a flame)', 'Concentration, up to 1 minute', TRUE, FALSE,
 'Choose a manufactured metal object, such as a metal weapon or a suit of heavy or medium metal armor, that you can see within range. You cause the object to glow red-hot. Any creature in physical contact with the object takes 2d8 fire damage when you cast the spell. Until the spell ends, you can use a bonus action on each of your subsequent turns to cause this damage again. If a creature is holding or wearing the object and takes the damage from it, the creature must succeed on a Constitution saving throw or drop the object if it can.',
 'When you cast this spell using a spell slot of 3rd level or higher, the damage increases by 1d8 for each slot level above 2nd.', '{"Bard","Druid"}'),

('Hold Person', 2, 'Enchantment', '1 action', '60 feet', 'V, S, M (a small, straight piece of iron)', 'Concentration, up to 1 minute', TRUE, FALSE,
 'Choose a humanoid that you can see within range. The target must succeed on a Wisdom saving throw or be paralyzed for the duration. At the end of each of its turns, the target can make another Wisdom saving throw. On a success, the spell ends on the target.',
 'When you cast this spell using a spell slot of 3rd level or higher, you can target one additional humanoid for each slot level above 2nd.', '{"Bard","Cleric","Druid","Sorcerer","Warlock","Wizard"}'),

('Invisibility', 2, 'Illusion', '1 action', 'Touch', 'V, S, M (an eyelash encased in gum arabic)', 'Concentration, up to 1 hour', TRUE, FALSE,
 'A creature you touch becomes invisible until the spell ends. Anything the target is wearing or carrying is invisible as long as it is on the target''s person. The spell ends for a target that attacks or casts a spell.',
 'When you cast this spell using a spell slot of 3rd level or higher, you can target one additional creature for each slot level above 2nd.', '{"Bard","Sorcerer","Warlock","Wizard"}'),

('Knock', 2, 'Transmutation', '1 action', '60 feet', 'V', 'Instantaneous', FALSE, FALSE,
 'Choose an object that you can see within range. The object can be a door, a box, a chest, a set of manacles, a padlock, or another object that contains a mundane or magical means that prevents access. A target that is held shut by a mundane lock or that is stuck or barred becomes unlocked, unstuck, or unbarred. If the object has multiple locks, only one of them is unlocked. If you choose a target that is held shut with arcane lock, that spell is suppressed for 10 minutes. When you cast the spell, a loud knock, audible from as far away as 300 feet, emanates from the target object.',
 NULL, '{"Bard","Sorcerer","Wizard"}'),

('Lesser Restoration', 2, 'Abjuration', '1 action', 'Touch', 'V, S', 'Instantaneous', FALSE, FALSE,
 'You touch a creature and can end either one disease or one condition afflicting it. The condition can be blinded, deafened, paralyzed, or poisoned.',
 NULL, '{"Bard","Cleric","Druid","Paladin","Ranger"}'),

('Levitate', 2, 'Transmutation', '1 action', '60 feet', 'V, S, M (either a small leather loop or a piece of golden wire bent into a cup shape with a long shank on one end)', 'Concentration, up to 10 minutes', TRUE, FALSE,
 'One creature or loose object of your choice that you can see within range rises vertically, up to 20 feet, and remains suspended there for the duration. The spell can levitate a target that weighs up to 500 pounds. An unwilling creature that succeeds on a Constitution saving throw is unaffected. The target can move only by pushing or pulling against a fixed object or surface within reach, which allows it to move as if it were climbing.',
 NULL, '{"Sorcerer","Wizard"}'),

('Locate Object', 2, 'Divination', '1 action', 'Self', 'V, S, M (a forked twig)', 'Concentration, up to 10 minutes', TRUE, FALSE,
 'Describe or name an object that is familiar to you. You sense the direction to the object''s location, as long as that object is within 1,000 feet of you. If the object is in motion, you know the direction of its movement. The spell can locate a specific object known to you, as long as you have seen it up close within 30 feet at least once. This spell can''t locate an object if any thickness of lead blocks a direct path between you and the object.',
 NULL, '{"Bard","Cleric","Druid","Paladin","Ranger","Wizard"}'),

('Magic Weapon', 2, 'Transmutation', '1 bonus action', 'Touch', 'V, S', 'Concentration, up to 1 hour', TRUE, FALSE,
 'You touch a nonmagical weapon. Until the spell ends, that weapon becomes a magic weapon with a +1 bonus to attack rolls and damage rolls.',
 'When you cast this spell using a spell slot of 4th level or higher, the bonus increases to +2. When you use a spell slot of 6th level or higher, the bonus increases to +3.', '{"Paladin","Wizard"}'),

('Mirror Image', 2, 'Illusion', '1 action', 'Self', 'V, S', '1 minute', FALSE, FALSE,
 'Three illusory duplicates of yourself appear in your space. Until the spell ends, the duplicates move with you and mimic your actions, shifting position so it''s impossible to track which image is real. Each time a creature targets you with an attack during the spell''s duration, roll a d20 to determine whether the attack instead targets one of your duplicates. If you have three duplicates, you must roll a 6 or higher; with two, 8 or higher; with one, 11 or higher. A duplicate''s AC equals 10 + your Dexterity modifier. If an attack hits a duplicate, the duplicate is destroyed.',
 NULL, '{"Sorcerer","Warlock","Wizard"}'),

('Misty Step', 2, 'Conjuration', '1 bonus action', 'Self', 'V', 'Instantaneous', FALSE, FALSE,
 'Briefly surrounded by silvery mist, you teleport up to 30 feet to an unoccupied space that you can see.',
 NULL, '{"Sorcerer","Warlock","Wizard"}'),

('Moonbeam', 2, 'Evocation', '1 action', '120 feet', 'V, S, M (several seeds of any moonseed plant and a piece of opalescent feldspar)', 'Concentration, up to 1 minute', TRUE, FALSE,
 'A silvery beam of pale light shines down in a 5-foot-radius, 40-foot-high cylinder centered on a point within range. Until the spell ends, dim light fills the cylinder. When a creature enters the spell''s area for the first time on a turn or starts its turn there, it is engulfed in ghostly flames that cause searing pain, and it must make a Constitution saving throw, taking 2d10 radiant damage on a failed save, or half as much on a success. A shapechanger makes its saving throw with disadvantage.',
 'When you cast this spell using a spell slot of 3rd level or higher, the damage increases by 1d10 for each slot level above 2nd.', '{"Druid"}'),

('Pass without Trace', 2, 'Abjuration', '1 action', 'Self', 'V, S, M (ashes from a burned leaf of mistletoe and a sprig of spruce)', 'Concentration, up to 1 hour', TRUE, FALSE,
 'A veil of shadows and silence radiates from you, masking you and your companions from detection. For the duration, each creature you choose within 30 feet of you has a +10 bonus to Dexterity (Stealth) checks and can''t be tracked except by magical means. A creature that receives this bonus leaves behind no tracks or other traces of its passage.',
 NULL, '{"Druid","Ranger"}'),

('Prayer of Healing', 2, 'Evocation', '10 minutes', '30 feet', 'V', 'Instantaneous', FALSE, FALSE,
 'Up to six creatures of your choice that you can see within range each regain hit points equal to 2d8 + your spellcasting ability modifier. This spell has no effect on undead or constructs.',
 'When you cast this spell using a spell slot of 3rd level or higher, the healing increases by 1d8 for each slot level above 2nd.', '{"Cleric"}'),

('Protection from Poison', 2, 'Abjuration', '1 action', 'Touch', 'V, S', '1 hour', FALSE, FALSE,
 'You touch a creature. If it is poisoned, you neutralize the poison. If more than one poison afflicts the target, you neutralize one poison that you know is present, or you neutralize one at random. For the duration, the target has advantage on saving throws against being poisoned, and it has resistance to poison damage.',
 NULL, '{"Cleric","Druid","Paladin","Ranger"}'),

('Ray of Enfeeblement', 2, 'Necromancy', '1 action', '60 feet', 'V, S', 'Concentration, up to 1 minute', TRUE, FALSE,
 'A black beam of enervating energy springs from your finger toward a creature within range. Make a ranged spell attack against the target. On a hit, the target deals only half damage with weapon attacks that use Strength until the spell ends. At the end of each of the target''s turns, it can make a Constitution saving throw against the spell. On a success, the spell ends.',
 NULL, '{"Warlock","Wizard"}'),

('Scorching Ray', 2, 'Evocation', '1 action', '120 feet', 'V, S', 'Instantaneous', FALSE, FALSE,
 'You create three rays of fire and hurl them at targets within range. You can hurl them at one target or several. Make a ranged spell attack for each ray. On a hit, the target takes 2d6 fire damage.',
 'When you cast this spell using a spell slot of 3rd level or higher, you create one additional ray for each slot level above 2nd.', '{"Sorcerer","Wizard"}'),

('See Invisibility', 2, 'Divination', '1 action', 'Self', 'V, S, M (a pinch of talc and a small sprinkling of powdered silver)', '1 hour', FALSE, FALSE,
 'For the duration, you see invisible creatures and objects as if they were visible, and you can see into the Ethereal Plane. Ethereal creatures and objects appear ghostly and translucent.',
 NULL, '{"Bard","Sorcerer","Wizard"}'),

('Shatter', 2, 'Evocation', '1 action', '60 feet', 'V, S, M (a chip of mica)', 'Instantaneous', FALSE, FALSE,
 'A sudden loud ringing noise, painfully intense, erupts from a point of your choice within range. Each creature in a 10-foot-radius sphere centered on that point must make a Constitution saving throw. A creature takes 3d8 thunder damage on a failed save, or half as much damage on a successful one. A creature made of inorganic material such as stone, crystal, or metal has disadvantage on this saving throw. A nonmagical object that isn''t being worn or carried also takes the damage if it''s in the spell''s area.',
 'When you cast this spell using a spell slot of 3rd level or higher, the damage increases by 1d8 for each slot level above 2nd.', '{"Bard","Sorcerer","Warlock","Wizard"}'),

('Silence', 2, 'Illusion', '1 action', '120 feet', 'V, S', 'Concentration, up to 10 minutes', TRUE, TRUE,
 'For the duration, no sound can be created within or pass through a 20-foot-radius sphere centered on a point you choose within range. Any creature or object entirely inside the sphere is immune to thunder damage, and creatures are deafened while entirely inside it. Casting a spell that includes a verbal component is impossible there.',
 NULL, '{"Bard","Cleric","Ranger"}'),

('Spider Climb', 2, 'Transmutation', '1 action', 'Touch', 'V, S, M (a drop of bitumen and a spider)', 'Concentration, up to 1 hour', TRUE, FALSE,
 'Until the spell ends, one willing creature you touch gains the ability to move up, down, and across vertical surfaces and upside down along ceilings, while leaving its hands free. The target also gains a climbing speed equal to its walking speed.',
 NULL, '{"Sorcerer","Warlock","Wizard"}'),

('Spiritual Weapon', 2, 'Evocation', '1 bonus action', '60 feet', 'V, S', '1 minute', FALSE, FALSE,
 'You create a floating, spectral weapon within range that lasts for the duration or until you cast this spell again. When you cast the spell, you can make a melee spell attack against a creature within 5 feet of the weapon. On a hit, the target takes force damage equal to 1d8 + your spellcasting ability modifier. As a bonus action on your turn, you can move the weapon up to 20 feet and repeat the attack against a creature within 5 feet of it.',
 'When you cast this spell using a spell slot of 3rd level or higher, the damage increases by 1d8 for every two slot levels above 2nd.', '{"Cleric"}'),

('Suggestion', 2, 'Enchantment', '1 action', '30 feet', 'V, M (a snake''s tongue and either a bit of honeycomb or a drop of sweet oil)', 'Concentration, up to 8 hours', TRUE, FALSE,
 'You suggest a course of activity (limited to a sentence or two) and magically influence a creature you can see within range that can hear and understand you. Creatures that can''t be charmed are immune to this effect. The suggestion must be worded in such a manner as to make the course of action sound reasonable. The target must make a Wisdom saving throw. On a failed save, it pursues the course of action you described to the best of its ability.',
 NULL, '{"Bard","Sorcerer","Warlock","Wizard"}'),

('Warding Bond', 2, 'Abjuration', '1 action', 'Touch', 'V, S, M (a pair of platinum rings worth at least 50 gp each, which you and the target must wear for the duration)', '1 hour', FALSE, FALSE,
 'This spell wards a willing creature you touch and creates a mystic connection between you and the target until the spell ends. While the target is within 60 feet of you, it gains a +1 bonus to AC and saving throws, and it has resistance to all damage. Also, each time it takes damage, you take the same amount of damage.',
 NULL, '{"Cleric"}'),

('Web', 2, 'Conjuration', '1 action', '60 feet', 'V, S, M (a bit of spiderweb)', 'Concentration, up to 1 hour', TRUE, FALSE,
 'You conjure a mass of thick, sticky webbing at a point of your choice within range. The webs fill a 20-foot cube from that point for the duration. The webs are difficult terrain and lightly obscure their area. If the webs aren''t anchored between two solid masses or layered across a floor, wall, or ceiling, they collapse on themselves and the spell ends at the start of your next turn. Each creature that starts its turn in the webs or that enters them during its turn must make a Dexterity saving throw. On a failed save, the creature is restrained as long as it remains in the webs or until it breaks free.',
 NULL, '{"Sorcerer","Wizard"}'),

('Zone of Truth', 2, 'Enchantment', '1 action', '60 feet', 'V, S', '10 minutes', FALSE, FALSE,
 'You create a magical zone that guards against deception in a 15-foot-radius sphere centered on a point of your choice within range. Until the spell ends, a creature that enters the spell''s area for the first time on a turn or starts its turn there must make a Charisma saving throw. On a failed save, a creature can''t speak a deliberate lie while in the radius. An affected creature is aware of the spell and can thus avoid answering questions to which it would normally respond with a lie.',
 NULL, '{"Bard","Cleric","Paladin"}'),

('Branding Smite', 2, 'Evocation', '1 bonus action', 'Self', 'V', 'Concentration, up to 1 minute', TRUE, FALSE,
 'The next time you hit a creature with a weapon attack before this spell ends, the weapon gleams with astral radiance as you strike. The attack deals an extra 2d6 radiant damage to the target, which becomes visible if it''s invisible, and the target sheds dim light in a 5-foot radius and can''t become invisible until the spell ends.',
 'When you cast this spell using a spell slot of 3rd level or higher, the extra damage increases by 1d6 for each slot level above 2nd.', '{"Paladin"}'),

('Find Traps', 2, 'Divination', '1 action', '120 feet', 'V, S', 'Instantaneous', FALSE, FALSE,
 'You sense the presence of any trap within range that is within line of sight. A trap, for the purpose of this spell, includes anything that would inflict a sudden or unexpected effect you consider harmful or undesirable, which was specifically intended as such by its creator. Thus, the spell would sense an area affected by the alarm spell, a glyph of warding, or a mechanical pit trap, but it would not reveal a natural weakness in the floor or an unstable ceiling. This spell merely reveals that a trap is present. You don''t learn the location of each trap, but you do learn the general nature of the danger posed by a trap you sense.',
 NULL, '{"Cleric","Druid","Ranger"}'),

('Magic Mouth', 2, 'Illusion', '1 minute', '30 feet', 'V, S, M (a small bit of honeycomb and jade dust worth at least 10 gp, which the spell consumes)', 'Until dispelled', FALSE, TRUE,
 'You implant a message within an object in range, a message that is uttered when a trigger condition is met. Choose an object that you can see and that isn''t being worn or carried by another creature. Then speak the message, which must be 25 words or less, though it can be delivered over as long as 10 minutes. Finally, determine the circumstance that will trigger the spell to deliver your message.',
 NULL, '{"Bard","Wizard"}'),

('Rope Trick', 2, 'Transmutation', '1 action', 'Touch', 'V, S, M (powdered corn extract and a twisted loop of parchment)', '1 hour', FALSE, FALSE,
 'You touch a length of rope that is up to 60 feet long. One end of the rope then rises into the air until the whole rope hangs perpendicular to the ground. At the upper end of the rope, an invisible entrance opens to an extradimensional space that lasts until the spell ends. The extradimensional space can be reached by climbing to the top of the rope. The space can hold as many as eight Medium or smaller creatures. Attacks and spells can''t cross through the entrance into or out of the extradimensional space.',
 NULL, '{"Wizard"}'),

('Locate Animals or Plants', 2, 'Divination', '1 action', 'Self', 'V, S, M (a bit of fur from a bloodhound)', 'Instantaneous', FALSE, TRUE,
 'Describe or name a specific kind of beast or plant. Concentrating on the voice of nature in your surroundings, you learn the direction and distance to the closest creature or plant of that kind within 5 miles, if any are present.',
 NULL, '{"Bard","Druid","Ranger"}');


-- ── LEVEL 3 SPELLS ──

INSERT INTO spells (name, level, school, casting_time, range, components, duration, concentration, ritual, description, higher_levels, classes) VALUES

('Animate Dead', 3, 'Necromancy', '1 minute', '10 feet', 'V, S, M (a drop of blood, a piece of flesh, and a pinch of bone dust)', 'Instantaneous', FALSE, FALSE,
 'This spell creates an undead servant. Choose a pile of bones or a corpse of a Medium or Small humanoid within range. Your spell imbues the target with a foul mimicry of life, raising it as an undead creature. The target becomes a skeleton if you chose bones or a zombie if you chose a corpse. On each of your turns, you can use a bonus action to mentally command any creature you made with this spell if the creature is within 60 feet of you.',
 'When you cast this spell using a spell slot of 4th level or higher, you animate or reassert control over two additional undead creatures for each slot level above 3rd.', '{"Cleric","Wizard"}'),

('Beacon of Hope', 3, 'Abjuration', '1 action', '30 feet', 'V, S', 'Concentration, up to 1 minute', TRUE, FALSE,
 'This spell bestows hope and vitality. Choose any number of creatures within range. For the duration, each target has advantage on Wisdom saving throws and death saving throws, and regains the maximum number of hit points possible from any healing.',
 NULL, '{"Cleric"}'),

('Bestow Curse', 3, 'Necromancy', '1 action', 'Touch', 'V, S', 'Concentration, up to 1 minute', TRUE, FALSE,
 'You touch a creature, and that creature must succeed on a Wisdom saving throw or become cursed for the duration of the spell. When you cast this spell, choose one of several curse forms: disadvantage on ability checks and saving throws with one ability score, disadvantage on attack rolls against you, Wisdom save each turn or waste action, or your attacks deal an extra 1d8 necrotic damage.',
 'If you cast this spell using a spell slot of 4th level or higher, the duration changes based on the slot level.', '{"Bard","Cleric","Wizard"}'),

('Blink', 3, 'Transmutation', '1 action', 'Self', 'V, S', '1 minute', FALSE, FALSE,
 'Roll a d20 at the end of each of your turns for the duration of the spell. On a roll of 11 or higher, you vanish from your current plane of existence and appear in the Ethereal Plane. At the start of your next turn, you return to an unoccupied space of your choice that you can see within 10 feet of the space you vanished from. If no unoccupied space is available within that range, you appear in the nearest unoccupied space. While on the Ethereal Plane, you can see and hear the plane you originated from, but everything there looks gray and you can''t see anything more than 60 feet away.',
 NULL, '{"Sorcerer","Wizard"}'),

('Call Lightning', 3, 'Conjuration', '1 action', '120 feet', 'V, S', 'Concentration, up to 10 minutes', TRUE, FALSE,
 'A storm cloud appears in the shape of a cylinder that is 10 feet tall with a 60-foot radius, centered on a point you can see within range directly above you. Each creature within 5 feet of a chosen point under the cloud must make a Dexterity saving throw, taking 3d10 lightning damage on a failed save, or half as much on a success. On each of your turns until the spell ends, you can use your action to call down lightning again. If you are outdoors in stormy conditions, the spell deals an extra 1d10 damage.',
 'When you cast this spell using a spell slot of 4th level or higher, the damage increases by 1d10 for each slot level above 3rd.', '{"Druid"}'),

('Clairvoyance', 3, 'Divination', '10 minutes', '1 mile', 'V, S, M (a focus worth at least 100 gp, either a jeweled horn for hearing or a glass eye for seeing)', 'Concentration, up to 10 minutes', TRUE, FALSE,
 'You create an invisible sensor within range in a location familiar to you or in an obvious location that is unfamiliar to you. The sensor remains in place for the duration and can''t be attacked or otherwise interacted with. When you cast the spell, you choose seeing or hearing. You can use the chosen sense through the sensor as if you were in its space.',
 NULL, '{"Bard","Cleric","Sorcerer","Wizard"}'),

('Conjure Animals', 3, 'Conjuration', '1 action', '60 feet', 'V, S', 'Concentration, up to 1 hour', TRUE, FALSE,
 'You summon fey spirits that take the form of beasts and appear in unoccupied spaces that you can see within range. Choose one of several options: one beast of CR 2 or lower, two beasts of CR 1 or lower, four beasts of CR 1/2 or lower, or eight beasts of CR 1/4 or lower. Each beast is also considered fey, and it disappears when it drops to 0 hit points or when the spell ends. The summoned creatures are friendly to you and your companions and obey your verbal commands.',
 'When you cast this spell using certain higher-level spell slots, you choose one of the summoning options above, and more creatures appear.', '{"Druid","Ranger"}'),

('Counterspell', 3, 'Abjuration', '1 reaction, which you take when you see a creature within 60 feet of you casting a spell', '60 feet', 'S', 'Instantaneous', FALSE, FALSE,
 'You attempt to interrupt a creature in the process of casting a spell. If the creature is casting a spell of 3rd level or lower, its spell fails and has no effect. If it is casting a spell of 4th level or higher, make an ability check using your spellcasting ability. The DC equals 10 + the spell''s level. On a success, the creature''s spell fails and has no effect.',
 'When you cast this spell using a spell slot of 4th level or higher, the interrupted spell has no effect if its level is equal to or less than the level of the spell slot you used.', '{"Sorcerer","Warlock","Wizard"}'),

('Create Food and Water', 3, 'Conjuration', '1 action', '30 feet', 'V, S', 'Instantaneous', FALSE, FALSE,
 'You create 45 pounds of food and 30 gallons of water on the ground or in containers within range, enough to sustain up to fifteen humanoids or five steeds for 24 hours. The food is bland but nourishing, and spoils if uneaten after 24 hours. The water is clean and doesn''t go bad.',
 NULL, '{"Cleric","Paladin"}'),

('Daylight', 3, 'Evocation', '1 action', '60 feet', 'V, S', '1 hour', FALSE, FALSE,
 'A 60-foot-radius sphere of light spreads out from a point you choose within range. The sphere is bright light and sheds dim light for an additional 60 feet. If you chose a point on an object you are holding or one that isn''t being worn or carried, the light shines from the object and moves with it. Completely covering the affected object with an opaque object blocks the light. If any of this spell''s area overlaps with an area of darkness created by a spell of 3rd level or lower, the spell that created the darkness is dispelled.',
 NULL, '{"Cleric","Druid","Paladin","Ranger","Sorcerer"}'),

('Dispel Magic', 3, 'Abjuration', '1 action', '120 feet', 'V, S', 'Instantaneous', FALSE, FALSE,
 'Choose one creature, object, or magical effect within range. Any spell of 3rd level or lower on the target ends. For each spell of 4th level or higher on the target, make an ability check using your spellcasting ability. The DC equals 10 + the spell''s level. On a successful check, the spell ends.',
 'When you cast this spell using a spell slot of 4th level or higher, you automatically end the effects of a spell on the target if the spell''s level is equal to or less than the level of the spell slot you used.', '{"Bard","Cleric","Druid","Paladin","Sorcerer","Warlock","Wizard"}'),

('Fear', 3, 'Illusion', '1 action', 'Self (30-foot cone)', 'V, S, M (a white feather or the heart of a hen)', 'Concentration, up to 1 minute', TRUE, FALSE,
 'You project a phantasmal image of a creature''s worst fears. Each creature in a 30-foot cone must succeed on a Wisdom saving throw or drop whatever it is holding and become frightened for the duration. While frightened by this spell, a creature must take the Dash action and move away from you by the safest available route on each of its turns, unless there is nowhere to move.',
 NULL, '{"Bard","Sorcerer","Warlock","Wizard"}'),

('Fireball', 3, 'Evocation', '1 action', '150 feet', 'V, S, M (a tiny ball of bat guano and sulfur)', 'Instantaneous', FALSE, FALSE,
 'A bright streak flashes from your pointing finger to a point you choose within range and then blossoms with a low roar into an explosion of flame. Each creature in a 20-foot-radius sphere centered on that point must make a Dexterity saving throw. A target takes 8d6 fire damage on a failed save, or half as much damage on a successful one. The fire spreads around corners. It ignites flammable objects in the area that aren''t being worn or carried.',
 'When you cast this spell using a spell slot of 4th level or higher, the damage increases by 1d6 for each slot level above 3rd.', '{"Sorcerer","Wizard"}'),

('Fly', 3, 'Transmutation', '1 action', 'Touch', 'V, S, M (a wing feather from any bird)', 'Concentration, up to 10 minutes', TRUE, FALSE,
 'You touch a willing creature. The target gains a flying speed of 60 feet for the duration. When the spell ends, the target falls if it is still aloft, unless it can stop the fall.',
 'When you cast this spell using a spell slot of 4th level or higher, you can target one additional creature for each slot level above 3rd.', '{"Sorcerer","Warlock","Wizard"}'),

('Gaseous Form', 3, 'Transmutation', '1 action', 'Touch', 'V, S, M (a bit of gauze and a wisp of smoke)', 'Concentration, up to 1 hour', TRUE, FALSE,
 'You transform a willing creature you touch, along with everything it''s wearing and carrying, into a misty cloud for the duration. The spell ends if the creature drops to 0 hit points. While in this form, the target''s only method of movement is a flying speed of 10 feet. The target can enter and occupy the space of another creature. The target has resistance to nonmagical damage, and it has advantage on Strength, Dexterity, and Constitution saving throws.',
 NULL, '{"Sorcerer","Warlock","Wizard"}'),

('Glyph of Warding', 3, 'Abjuration', '1 hour', 'Touch', 'V, S, M (incense and powdered diamond worth at least 200 gp, which the spell consumes)', 'Until dispelled or triggered', FALSE, FALSE,
 'When you cast this spell, you inscribe a glyph that later unleashes a magical effect. You inscribe it either on a surface or within an object that can be closed to conceal the glyph. If the surface or object is moved more than 10 feet from where you cast this spell, the glyph is broken and the spell ends. When the glyph is triggered, it can either erupt with magical energy in a 20-foot-radius sphere (each creature takes 5d8 damage of your chosen type) or cast a stored spell (up to 3rd level).',
 'When you cast this spell using a spell slot of 4th level or higher, the damage of an explosive runes glyph increases by 1d8 for each slot level above 3rd.', '{"Bard","Cleric","Wizard"}'),

('Haste', 3, 'Transmutation', '1 action', '30 feet', 'V, S, M (a shaving of licorice root)', 'Concentration, up to 1 minute', TRUE, FALSE,
 'Choose a willing creature that you can see within range. Until the spell ends, the target''s speed is doubled, it gains a +2 bonus to AC, it has advantage on Dexterity saving throws, and it gains an additional action on each of its turns. That action can be used only to take the Attack (one weapon attack only), Dash, Disengage, Hide, or Use an Object action. When the spell ends, the target can''t move or take actions until after its next turn, as a wave of lethargy sweeps over it.',
 NULL, '{"Sorcerer","Wizard"}'),

('Hypnotic Pattern', 3, 'Illusion', '1 action', '120 feet', 'S, M (a glowing stick of incense or a crystal vial filled with phosphorescent material)', 'Concentration, up to 1 minute', TRUE, FALSE,
 'You create a twisting pattern of colors that weaves through the air inside a 30-foot cube within range. The pattern appears for a moment and vanishes. Each creature in the area who sees the pattern must make a Wisdom saving throw. On a failed save, the creature becomes charmed for the duration. While charmed by this spell, the creature is incapacitated and has a speed of 0. The spell ends for an affected creature if it takes any damage or if someone else uses an action to shake the creature out of its stupor.',
 NULL, '{"Bard","Sorcerer","Warlock","Wizard"}'),

('Lightning Bolt', 3, 'Evocation', '1 action', 'Self (100-foot line)', 'V, S, M (a bit of fur and a rod of amber, crystal, or glass)', 'Instantaneous', FALSE, FALSE,
 'A stroke of lightning forming a line 100 feet long and 5 feet wide blasts out from you in a direction you choose. Each creature in the line must make a Dexterity saving throw. A creature takes 8d6 lightning damage on a failed save, or half as much damage on a successful one. The lightning ignites flammable objects in the area that aren''t being worn or carried.',
 'When you cast this spell using a spell slot of 4th level or higher, the damage increases by 1d6 for each slot level above 3rd.', '{"Sorcerer","Wizard"}'),

('Magic Circle', 3, 'Abjuration', '1 minute', '10 feet', 'V, S, M (holy water or powdered silver and iron worth at least 100 gp, which the spell consumes)', '1 hour', FALSE, FALSE,
 'You create a 10-foot-radius, 20-foot-tall cylinder of magical energy centered on a point on the ground that you can see within range. Choose one or more of the following types of creatures: celestials, elementals, fey, fiends, or undead. The circle affects a creature of the chosen type in the following ways: the creature can''t willingly enter the cylinder, the creature has disadvantage on attack rolls against targets within the cylinder, and targets within the cylinder can''t be charmed, frightened, or possessed by the creature.',
 'When you cast this spell using a spell slot of 4th level or higher, the duration increases by 1 hour for each slot level above 3rd.', '{"Cleric","Paladin","Warlock","Wizard"}'),

('Major Image', 3, 'Illusion', '1 action', '120 feet', 'V, S, M (a bit of fleece)', 'Concentration, up to 10 minutes', TRUE, FALSE,
 'You create the image of an object, a creature, or some other visible phenomenon that is no larger than a 20-foot cube. The image appears at a spot that you can see within range and lasts for the duration. It seems completely real, including sounds, smells, and temperature appropriate to the thing depicted. You can''t create sufficient heat or cold to cause damage, a sound loud enough to deal thunder damage, or a smell that might sicken a creature. You can use your action to cause the image to move to any other spot within range.',
 'When you cast this spell using a spell slot of 6th level or higher, the spell lasts until dispelled, without requiring your concentration.', '{"Bard","Sorcerer","Warlock","Wizard"}'),

('Mass Healing Word', 3, 'Evocation', '1 bonus action', '60 feet', 'V', 'Instantaneous', FALSE, FALSE,
 'As you call out words of restoration, up to six creatures of your choice that you can see within range regain hit points equal to 1d4 + your spellcasting ability modifier. This spell has no effect on undead or constructs.',
 'When you cast this spell using a spell slot of 4th level or higher, the healing increases by 1d4 for each slot level above 3rd.', '{"Cleric"}'),

('Nondetection', 3, 'Abjuration', '1 action', 'Touch', 'V, S, M (a pinch of diamond dust worth 25 gp sprinkled over the target, which the spell consumes)', '8 hours', FALSE, FALSE,
 'For the duration, you hide a target that you touch from divination magic. The target can be a willing creature or a place or an object no larger than 10 feet in any dimension. The target can''t be targeted by any divination magic or perceived through magical scrying sensors.',
 NULL, '{"Bard","Ranger","Wizard"}'),

('Plant Growth', 3, 'Transmutation', '1 action or 8 hours', '150 feet', 'V, S', 'Instantaneous', FALSE, FALSE,
 'This spell channels vitality into plants within a specific area. There are two possible uses for the spell. If you cast this spell using 1 action, choose a point within range. All normal plants in a 100-foot radius centered on that point become thick and overgrown, making the area difficult terrain. If you cast this spell over 8 hours, you enrich the land. All plants in a half-mile radius centered on a point within range become enriched for 1 year, yielding twice the normal amount of food when harvested.',
 NULL, '{"Bard","Druid","Ranger"}'),

('Protection from Energy', 3, 'Abjuration', '1 action', 'Touch', 'V, S', 'Concentration, up to 1 hour', TRUE, FALSE,
 'For the duration, the willing creature you touch has resistance to one damage type of your choice: acid, cold, fire, lightning, or thunder.',
 NULL, '{"Cleric","Druid","Ranger","Sorcerer","Wizard"}'),

('Remove Curse', 3, 'Abjuration', '1 action', 'Touch', 'V, S', 'Instantaneous', FALSE, FALSE,
 'At your touch, all curses affecting one creature or object end. If the object is a cursed magic item, its curse remains, but the spell breaks its owner''s attunement to the object so it can be removed or discarded.',
 NULL, '{"Cleric","Paladin","Warlock","Wizard"}'),

('Revivify', 3, 'Necromancy', '1 action', 'Touch', 'V, S, M (diamonds worth 300 gp, which the spell consumes)', 'Instantaneous', FALSE, FALSE,
 'You touch a creature that has died within the last minute. That creature returns to life with 1 hit point. This spell can''t return to life a creature that has died of old age, nor can it restore any missing body parts.',
 NULL, '{"Cleric","Paladin"}'),

('Sending', 3, 'Evocation', '1 action', 'Unlimited', 'V, S, M (a short piece of fine copper wire)', '1 round', FALSE, FALSE,
 'You send a short message of twenty-five words or less to a creature with which you are familiar. The creature hears the message in its mind, recognizes you as the sender if it knows you, and can answer in a like manner immediately. You can send the message across any distance and even to other planes of existence.',
 NULL, '{"Bard","Cleric","Wizard"}'),

('Sleet Storm', 3, 'Conjuration', '1 action', '150 feet', 'V, S, M (a pinch of dust and a few drops of water)', 'Concentration, up to 1 minute', TRUE, FALSE,
 'Until the spell ends, freezing rain and sleet fall in a 20-foot-tall cylinder with a 40-foot radius centered on a point you choose within range. The area is heavily obscured, and exposed flames in the area are doused. The ground in the area is covered with slick ice, making it difficult terrain. When a creature enters the spell''s area for the first time on a turn or starts its turn there, it must make a Dexterity saving throw. On a failed save, it falls prone. If a creature starts its turn in the spell''s area and is concentrating on a spell, it must make a successful Constitution saving throw or lose concentration.',
 NULL, '{"Druid","Sorcerer","Wizard"}'),

('Slow', 3, 'Transmutation', '1 action', '120 feet', 'V, S, M (a drop of molasses)', 'Concentration, up to 1 minute', TRUE, FALSE,
 'You alter time around up to six creatures of your choice in a 40-foot cube within range. Each target must succeed on a Wisdom saving throw or be affected. An affected target''s speed is halved, it takes a -2 penalty to AC and Dexterity saving throws, and it can''t use reactions. On its turn, it can use either an action or a bonus action, not both. It can''t make more than one melee or ranged attack during its turn. If the creature attempts to cast a spell with a casting time of 1 action, roll a d20; on an 11 or higher, the spell takes effect next turn instead.',
 NULL, '{"Sorcerer","Wizard"}'),

('Speak with Dead', 3, 'Necromancy', '1 action', '10 feet', 'V, S, M (burning incense)', '10 minutes', FALSE, FALSE,
 'You grant the semblance of life and intelligence to a corpse of your choice within range, allowing it to answer the questions you pose. The corpse must still have a mouth and can''t be undead. The spell fails if the corpse was the target of this spell within the last 10 days. You can ask the corpse up to five questions. The corpse knows only what it knew in life. Answers are usually brief, cryptic, or repetitive, and the corpse is under no compulsion to offer a truthful answer.',
 NULL, '{"Bard","Cleric"}'),

('Spirit Guardians', 3, 'Conjuration', '1 action', 'Self (15-foot radius)', 'V, S, M (a holy symbol)', 'Concentration, up to 10 minutes', TRUE, FALSE,
 'You call forth spirits to protect you. They flit around you to a distance of 15 feet for the duration. If you are good or neutral, their spectral form appears angelic or fey. If you are evil, they appear fiendish. When you cast this spell, you can designate any number of creatures you can see to be unaffected by it. An affected creature''s speed is halved in the area, and when the creature enters the area for the first time on a turn or starts its turn there, it must make a Wisdom saving throw, taking 3d8 radiant (or necrotic) damage on a failed save, or half on a success.',
 'When you cast this spell using a spell slot of 4th level or higher, the damage increases by 1d8 for each slot level above 3rd.', '{"Cleric"}'),

('Stinking Cloud', 3, 'Conjuration', '1 action', '90 feet', 'V, S, M (a rotten egg or several skunk cabbage leaves)', 'Concentration, up to 1 minute', TRUE, FALSE,
 'You create a 20-foot-radius sphere of yellow, nauseating gas centered on a point within range. The cloud spreads around corners, and its area is heavily obscured. The cloud lingers in the air for the duration. Each creature that is completely within the cloud at the start of its turn must make a Constitution saving throw against poison. On a failed save, the creature spends its action that turn retching and reeling. Creatures that don''t need to breathe or are immune to poison automatically succeed on this saving throw.',
 NULL, '{"Bard","Sorcerer","Wizard"}'),

('Tongues', 3, 'Divination', '1 action', 'Touch', 'V, M (a small clay model of a ziggurat)', '1 hour', FALSE, FALSE,
 'This spell grants the creature you touch the ability to understand any spoken language it hears. Moreover, when the target speaks, any creature that knows at least one language and can hear the target understands what it says.',
 NULL, '{"Bard","Cleric","Sorcerer","Warlock","Wizard"}'),

('Vampiric Touch', 3, 'Necromancy', '1 action', 'Self', 'V, S', 'Concentration, up to 1 minute', TRUE, FALSE,
 'The touch of your shadow-wreathed hand can siphon life force from others to heal your wounds. Make a melee spell attack against a creature within your reach. On a hit, the target takes 3d6 necrotic damage, and you regain hit points equal to half the amount of necrotic damage dealt. Until the spell ends, you can make the attack again on each of your turns as an action.',
 'When you cast this spell using a spell slot of 4th level or higher, the damage increases by 1d6 for each slot level above 3rd.', '{"Warlock","Wizard"}'),

('Water Breathing', 3, 'Transmutation', '1 action', '30 feet', 'V, S, M (a short reed or piece of straw)', '24 hours', FALSE, TRUE,
 'This spell grants up to ten willing creatures you can see within range the ability to breathe underwater until the spell ends. Affected creatures also retain their normal mode of respiration.',
 NULL, '{"Druid","Ranger","Sorcerer","Wizard"}'),

('Water Walk', 3, 'Transmutation', '1 action', '30 feet', 'V, S, M (a piece of cork)', '1 hour', FALSE, TRUE,
 'This spell grants the ability to move across any liquid surface—such as water, acid, mud, snow, quicksand, or lava—as if it were harmless solid ground (creatures crossing molten lava can still take damage from the heat). Up to ten willing creatures you can see within range gain this ability for the duration. If you target a creature submerged in a liquid, the spell carries the target to the surface at a rate of 60 feet per round.',
 NULL, '{"Cleric","Druid","Ranger","Sorcerer"}'),

('Wind Wall', 3, 'Evocation', '1 action', '120 feet', 'V, S, M (a tiny fan and a feather of exotic origin)', 'Concentration, up to 1 minute', TRUE, FALSE,
 'A wall of strong wind rises from the ground at a point you choose within range. You can make the wall up to 50 feet long, 15 feet high, and 1 foot thick. You can shape the wall in any way you choose so long as it makes one continuous path along the ground. Each creature in the area when the wall appears must make a Strength saving throw, taking 3d8 bludgeoning damage on a failure, or half on a success. The strong wind keeps fog, smoke, and other gases at bay. Small or smaller flying creatures or objects can''t pass through the wall. Arrows, bolts, and other ordinary projectiles launched at targets behind the wall are deflected upward and automatically miss.',
 NULL, '{"Cleric","Druid","Ranger"}'),

('Leomund''s Tiny Hut', 3, 'Evocation', '1 minute', 'Self (10-foot-radius hemisphere)', 'V, S, M (a small crystal bead)', '8 hours', FALSE, TRUE,
 'A 10-foot-radius immobile dome of force springs into existence around and above you and remains stationary for the duration. The dome can contain up to nine Medium or smaller creatures. The spell fails if its area includes a larger creature or more than nine creatures. The atmosphere inside the space is comfortable and dry, regardless of the weather outside. Until the spell ends, you can command the interior to become dimly lit or dark. The dome is opaque from the outside, of any color you choose, but it is transparent from the inside. Creatures and objects within the dome when you cast this spell can move through it freely. All other creatures and objects are barred from passing through it.',
 NULL, '{"Bard","Wizard"}'),

('Meld into Stone', 3, 'Transmutation', '1 action', 'Touch', 'V, S', '8 hours', FALSE, TRUE,
 'You step into a stone object or surface large enough to fully contain your body, melding yourself and all the equipment you carry with the stone for the duration. Using your movement, you step into the stone at a point you can touch. Nothing of your presence remains visible or otherwise detectable by nonmagical senses. While merged with the stone, you can''t see what occurs outside it, and any Wisdom (Perception) checks you make to hear sounds outside it are made with disadvantage. You remain aware of the passage of time and can cast spells on yourself while merged in the stone.',
 NULL, '{"Cleric","Druid"}'),

('Phantom Steed', 3, 'Illusion', '1 minute', '30 feet', 'V, S', '1 hour', FALSE, TRUE,
 'A Large quasi-real, horselike creature appears on the ground in an unoccupied space of your choice within range. You decide the creature''s appearance, but it is equipped with a saddle, bit, and bridle. Any equipment created by the spell vanishes in a puff of smoke if it is carried more than 10 feet away from the steed. The creature uses the statistics for a riding horse. It has a speed of 100 feet and can travel 10 miles in an hour, or 13 miles at a fast pace.',
 NULL, '{"Wizard"}');


-- ── LEVEL 4 SPELLS ──

INSERT INTO spells (name, level, school, casting_time, range, components, duration, concentration, ritual, description, higher_levels, classes) VALUES

('Arcane Eye', 4, 'Divination', '1 action', '30 feet', 'V, S, M (a bit of bat fur)', 'Concentration, up to 1 hour', TRUE, FALSE,
 'You create an invisible, magical eye within range that hovers in the air for the duration. You mentally receive visual information from the eye, which has normal vision and darkvision out to 30 feet. The eye can look in every direction. As an action, you can move the eye up to 30 feet in any direction. The eye can pass through openings as small as 1 inch across.',
 NULL, '{"Wizard"}'),

('Banishment', 4, 'Abjuration', '1 action', '60 feet', 'V, S, M (an item distasteful to the target)', 'Concentration, up to 1 minute', TRUE, FALSE,
 'You attempt to send one creature that you can see within range to another plane of existence. The target must succeed on a Charisma saving throw or be banished. If the target is native to the plane of existence you''re on, you banish the target to a harmless demiplane. While there, the target is incapacitated. If the spell lasts for the full minute, the target remains in the demiplane until freed. If the target is native to a different plane, it is returned to its home plane.',
 'When you cast this spell using a spell slot of 5th level or higher, you can target one additional creature for each slot level above 4th.', '{"Cleric","Paladin","Sorcerer","Warlock","Wizard"}'),

('Blight', 4, 'Necromancy', '1 action', '30 feet', 'V, S', 'Instantaneous', FALSE, FALSE,
 'Necromantic energy washes over a creature of your choice that you can see within range, draining moisture and vitality from it. The target must make a Constitution saving throw. The target takes 8d8 necrotic damage on a failed save, or half as much damage on a successful one. This spell has no effect on undead or constructs. If you target a plant creature or a magical plant, it makes the saving throw with disadvantage, and the spell deals maximum damage to it.',
 'When you cast this spell using a spell slot of 5th level or higher, the damage increases by 1d8 for each slot level above 4th.', '{"Druid","Sorcerer","Warlock","Wizard"}'),

('Compulsion', 4, 'Enchantment', '1 action', '30 feet', 'V, S', 'Concentration, up to 1 minute', TRUE, FALSE,
 'Creatures of your choice that you can see within range and that can hear you must make a Wisdom saving throw. A target automatically succeeds on this saving throw if it can''t be charmed. On a failed save, a target is affected by this spell. Until the spell ends, you can use a bonus action on each of your turns to designate a direction that is horizontal to you. Each affected target must use as much of its movement as possible to move in that direction on its next turn.',
 NULL, '{"Bard"}'),

('Confusion', 4, 'Enchantment', '1 action', '90 feet', 'V, S, M (three nut shells)', 'Concentration, up to 1 minute', TRUE, FALSE,
 'This spell assaults and twists creatures'' minds, spawning delusions and provoking uncontrolled action. Each creature in a 10-foot-radius sphere centered on a point you choose within range must succeed on a Wisdom saving throw when you cast this spell or be affected by it. An affected target can''t take reactions and must roll a d10 at the start of each of its turns to determine its behavior for that turn.',
 'When you cast this spell using a spell slot of 5th level or higher, the radius of the sphere increases by 5 feet for each slot level above 4th.', '{"Bard","Druid","Sorcerer","Wizard"}'),

('Conjure Minor Elementals', 4, 'Conjuration', '1 minute', '90 feet', 'V, S', 'Concentration, up to 1 hour', TRUE, FALSE,
 'You summon elementals that appear in unoccupied spaces that you can see within range. You choose one of several options: one elemental of CR 2 or lower, two elementals of CR 1 or lower, four elementals of CR 1/2 or lower, or eight elementals of CR 1/4 or lower. An elemental summoned by this spell disappears when it drops to 0 hit points or when the spell ends. The summoned creatures are friendly to you and your companions and obey your verbal commands.',
 'When you cast this spell using certain higher-level spell slots, more creatures appear.', '{"Druid","Wizard"}'),

('Conjure Woodland Beings', 4, 'Conjuration', '1 action', '60 feet', 'V, S, M (one holly berry per creature summoned)', 'Concentration, up to 1 hour', TRUE, FALSE,
 'You summon fey creatures that appear in unoccupied spaces that you can see within range. Choose one of several options: one fey creature of CR 2 or lower, two fey creatures of CR 1 or lower, four fey creatures of CR 1/2 or lower, or eight fey creatures of CR 1/4 or lower. A summoned creature disappears when it drops to 0 hit points or when the spell ends. The summoned creatures are friendly to you and your companions.',
 'When you cast this spell using certain higher-level spell slots, more creatures appear.', '{"Druid","Ranger"}'),

('Control Water', 4, 'Transmutation', '1 action', '300 feet', 'V, S, M (a drop of water and a pinch of dust)', 'Concentration, up to 10 minutes', TRUE, FALSE,
 'Until the spell ends, you control any freestanding water inside an area you choose that is a cube up to 100 feet on a side. You choose one of several effects when you cast the spell: Flood (raise the water level by up to 20 feet), Part Water (cause water to create a trench), Redirect Flow (cause flowing water to move in a direction you choose), or Whirlpool (create a vortex 5 to 50 feet wide). As an action on your turn, you can repeat the same effect or choose a different one.',
 NULL, '{"Cleric","Druid","Wizard"}'),

('Death Ward', 4, 'Abjuration', '1 action', 'Touch', 'V, S', '8 hours', FALSE, FALSE,
 'You touch a creature and grant it a measure of protection from death. The first time the target would drop to 0 hit points as a result of taking damage, the target instead drops to 1 hit point, and the spell ends. If the spell is still in effect when the target is subjected to an effect that would kill it instantaneously without dealing damage, that effect is negated against the target, and the spell ends.',
 NULL, '{"Cleric","Paladin"}'),

('Dimension Door', 4, 'Conjuration', '1 action', '500 feet', 'V', 'Instantaneous', FALSE, FALSE,
 'You teleport yourself from your current location to any other spot within range. You arrive at exactly the spot desired. It can be a place you can see, one you can visualize, or one you can describe by stating distance and direction. You can bring along objects as long as their weight doesn''t exceed what you can carry. You can also bring one willing creature of your size or smaller who is carrying gear up to its carrying capacity.',
 NULL, '{"Bard","Sorcerer","Warlock","Wizard"}'),

('Divination', 4, 'Divination', '1 action', 'Self', 'V, S, M (incense and a sacrificial offering appropriate to your religion, together worth at least 25 gp, which the spell consumes)', 'Instantaneous', FALSE, TRUE,
 'Your magic and an offering put you in contact with a god or a god''s servants. You ask a single question concerning a specific goal, event, or activity to occur within 7 days. The DM offers a truthful reply. The reply might be a short phrase, a cryptic rhyme, or an omen. The spell doesn''t take into account any possible circumstances that might change the outcome.',
 NULL, '{"Cleric"}'),

('Dominate Beast', 4, 'Enchantment', '1 action', '60 feet', 'V, S', 'Concentration, up to 1 minute', TRUE, FALSE,
 'You attempt to beguile a beast that you can see within range. It must succeed on a Wisdom saving throw or be charmed by you for the duration. If you or creatures that are friendly to you are fighting it, it has advantage on the saving throw. While the beast is charmed, you have a telepathic link with it as long as the two of you are on the same plane. You can use this telepathic link to issue commands to the creature while you are conscious, which it does its best to obey.',
 'When you cast this spell with a 5th-level spell slot, the duration is concentration, up to 10 minutes. With a 6th-level slot, up to 1 hour. With a 7th-level slot or higher, up to 8 hours.', '{"Druid","Sorcerer"}'),

('Evard''s Black Tentacles', 4, 'Conjuration', '1 action', '90 feet', 'V, S, M (a piece of tentacle from a giant octopus or a giant squid)', 'Concentration, up to 1 minute', TRUE, FALSE,
 'Squirming, ebony tentacles fill a 20-foot square on ground that you can see within range. For the duration, these tentacles turn the ground in the area into difficult terrain. When a creature enters the affected area for the first time on a turn or starts its turn there, the creature must succeed on a Dexterity saving throw or take 3d6 bludgeoning damage and be restrained by the tentacles until the spell ends. A creature that starts its turn in the area and is already restrained by the tentacles takes 3d6 bludgeoning damage.',
 NULL, '{"Wizard"}'),

('Fabricate', 4, 'Transmutation', '10 minutes', '120 feet', 'V, S', 'Instantaneous', FALSE, FALSE,
 'You convert raw materials into products of the same material. For example, you can fabricate a wooden bridge from a clump of trees, a rope from a patch of hemp, and clothes from flax or wool. Choose raw materials that you can see within range. You can fabricate a Large or smaller object (contained within a 10-foot cube), given a sufficient quantity of raw material. If you are working with metal, stone, or another mineral substance, the fabricated object can be no larger than Medium.',
 NULL, '{"Wizard"}'),

('Fire Shield', 4, 'Evocation', '1 action', 'Self', 'V, S, M (a bit of phosphorus or a firefly)', '10 minutes', FALSE, FALSE,
 'Thin and wispy flames wreathe your body for the duration, shedding bright light in a 10-foot radius and dim light for an additional 10 feet. You can end the spell early by using an action to dismiss it. The flames provide you with a warm shield or a chill shield, as you choose. The warm shield grants you resistance to cold damage, and the chill shield grants you resistance to fire damage. In addition, whenever a creature within 5 feet of you hits you with a melee attack, the shield erupts with flame. The attacker takes 2d8 fire damage from a warm shield, or 2d8 cold damage from a cold shield.',
 NULL, '{"Wizard"}'),

('Freedom of Movement', 4, 'Abjuration', '1 action', 'Touch', 'V, S, M (a leather strap, bound around the arm or a similar appendage)', '1 hour', FALSE, FALSE,
 'You touch a willing creature. For the duration, the target''s movement is unaffected by difficult terrain, and spells and other magical effects can neither reduce the target''s speed nor cause the target to be paralyzed or restrained. The target can also spend 5 feet of movement to automatically escape from nonmagical restraints. Additionally, being underwater imposes no penalties on the target''s movement or attacks.',
 NULL, '{"Bard","Cleric","Druid","Ranger"}'),

('Giant Insect', 4, 'Transmutation', '1 action', '30 feet', 'V, S', 'Concentration, up to 10 minutes', TRUE, FALSE,
 'You transform up to ten centipedes, three spiders, five wasps, or one scorpion within range into giant versions of their natural forms for the duration. The DM might allow you to choose different targets. A centipede becomes a giant centipede, a spider becomes a giant spider, a wasp becomes a giant wasp, and a scorpion becomes a giant scorpion. Each creature obeys your verbal commands, and in combat, they act on your turn each round.',
 NULL, '{"Druid"}'),

('Greater Invisibility', 4, 'Illusion', '1 action', 'Touch', 'V, S', 'Concentration, up to 1 minute', TRUE, FALSE,
 'You or a creature you touch becomes invisible until the spell ends. Anything the target is wearing or carrying is invisible as long as it is on the target''s person.',
 NULL, '{"Bard","Sorcerer","Wizard"}'),

('Guardian of Faith', 4, 'Conjuration', '1 action', '30 feet', 'V', '8 hours', FALSE, FALSE,
 'A Large spectral guardian appears and hovers for the duration in an unoccupied space of your choice that you can see within range. The guardian occupies that space and is indistinct except for a gleaming sword and shield emblazoned with the symbol of your deity. Any creature hostile to you that moves to a space within 10 feet of the guardian for the first time on a turn must succeed on a Dexterity saving throw. The creature takes 20 radiant damage on a failed save, or half as much damage on a successful one. The guardian vanishes when it has dealt a total of 60 damage.',
 NULL, '{"Cleric"}'),

('Hallucinatory Terrain', 4, 'Illusion', '10 minutes', '300 feet', 'V, S, M (a stone, a twig, and a bit of green plant)', '24 hours', FALSE, FALSE,
 'You make natural terrain in a 150-foot cube in range look, sound, and smell like some other sort of natural terrain. Thus, open fields or a road can be made to resemble a swamp, hill, crevasse, or some other difficult or impassable terrain. A pond can be made to seem like a grassy meadow, a precipice like a gentle slope, or a rock-strewn gully like a wide and smooth road. Manufactured structures, equipment, and creatures within the area aren''t changed in appearance.',
 NULL, '{"Bard","Druid","Warlock","Wizard"}'),

('Ice Storm', 4, 'Evocation', '1 action', '300 feet', 'V, S, M (a pinch of dust and a few drops of water)', 'Instantaneous', FALSE, FALSE,
 'A hail of rock-hard ice pounds to the ground in a 20-foot-radius, 40-foot-high cylinder centered on a point within range. Each creature in the cylinder must make a Dexterity saving throw. A creature takes 2d8 bludgeoning damage and 4d6 cold damage on a failed save, or half as much damage on a successful one. Hailstones turn the storm''s area of effect into difficult terrain until the end of your next turn.',
 'When you cast this spell using a spell slot of 5th level or higher, the bludgeoning damage increases by 1d8 for each slot level above 4th.', '{"Druid","Sorcerer","Wizard"}'),

('Locate Creature', 4, 'Divination', '1 action', 'Self', 'V, S, M (a bit of fur from a bloodhound)', 'Concentration, up to 1 hour', TRUE, FALSE,
 'Describe or name a creature that is familiar to you. You sense the direction to the creature''s location, as long as that creature is within 1,000 feet of you. If the creature is moving, you know the direction of its movement. The spell can locate a specific creature known to you, or the nearest creature of a specific kind, as long as you have seen such a creature up close within 30 feet at least once. If the creature you described or named is in a different form, this spell doesn''t locate the creature. This spell can''t locate a creature if running water at least 10 feet wide blocks a direct path between you and the creature.',
 NULL, '{"Bard","Cleric","Druid","Paladin","Ranger","Wizard"}'),

('Phantasmal Killer', 4, 'Illusion', '1 action', '120 feet', 'V, S', 'Concentration, up to 1 minute', TRUE, FALSE,
 'You tap into the nightmares of a creature you can see within range and create an illusory manifestation of its deepest fears, visible only to that creature. The target must make a Wisdom saving throw. On a failed save, the target becomes frightened for the duration. At the end of each of the target''s turns before the spell ends, the target must succeed on a Wisdom saving throw or take 4d10 psychic damage. On a successful save, the spell ends.',
 'When you cast this spell using a spell slot of 5th level or higher, the damage increases by 1d10 for each slot level above 4th.', '{"Wizard"}'),

('Polymorph', 4, 'Transmutation', '1 action', '60 feet', 'V, S, M (a caterpillar cocoon)', 'Concentration, up to 1 hour', TRUE, FALSE,
 'This spell transforms a creature that you can see within range into a new form. An unwilling creature must make a Wisdom saving throw to avoid the effect. The spell has no effect on a shapechanger or a creature with 0 hit points. The transformation lasts for the duration, or until the target drops to 0 hit points or dies. The new form can be any beast whose challenge rating is equal to or less than the target''s (or the target''s level). The target''s game statistics, including mental ability scores, are replaced by the statistics of the chosen beast.',
 NULL, '{"Bard","Druid","Sorcerer","Wizard"}'),

('Stone Shape', 4, 'Transmutation', '1 action', 'Touch', 'V, S, M (soft clay, which must be worked into roughly the desired shape of the stone object)', 'Instantaneous', FALSE, FALSE,
 'You touch a stone object of Medium size or smaller or a section of stone no more than 5 feet in any dimension and form it into any shape that suits your purpose. So, for example, you could shape a large rock into a weapon, idol, or coffer, or make a small passage through a wall, as long as the wall is less than 5 feet thick. You could also shape a stone door or its frame to seal the door shut.',
 NULL, '{"Cleric","Druid","Wizard"}'),

('Stoneskin', 4, 'Abjuration', '1 action', 'Touch', 'V, S, M (diamond dust worth 100 gp, which the spell consumes)', 'Concentration, up to 1 hour', TRUE, FALSE,
 'This spell turns the flesh of a willing creature you touch as hard as stone. Until the spell ends, the target has resistance to nonmagical bludgeoning, piercing, and slashing damage.',
 NULL, '{"Druid","Ranger","Sorcerer","Wizard"}'),

('Wall of Fire', 4, 'Evocation', '1 action', '120 feet', 'V, S, M (a small piece of phosphorus)', 'Concentration, up to 1 minute', TRUE, FALSE,
 'You create a wall of fire on a solid surface within range. You can make the wall up to 60 feet long, 20 feet high, and 1 foot thick, or a ringed wall up to 20 feet in diameter, 20 feet high, and 1 foot thick. The wall is opaque and lasts for the duration. When the wall appears, each creature within its area must make a Dexterity saving throw. On a failed save, a creature takes 5d8 fire damage, or half as much on a successful save. One side of the wall, selected by you when you cast this spell, deals 5d8 fire damage to each creature that ends its turn within 10 feet of that side or inside the wall.',
 'When you cast this spell using a spell slot of 5th level or higher, the damage increases by 1d8 for each slot level above 4th.', '{"Druid","Sorcerer","Wizard"}'),

('Staggering Smite', 4, 'Evocation', '1 bonus action', 'Self', 'V', 'Concentration, up to 1 minute', TRUE, FALSE,
 'The next time you hit a creature with a melee weapon attack during this spell''s duration, your weapon pierces both body and mind, and the attack deals an extra 4d6 psychic damage to the target. The target must make a Wisdom saving throw. On a failed save, it has disadvantage on attack rolls and ability checks, and can''t take reactions, until the end of its next turn.',
 NULL, '{"Paladin"}');

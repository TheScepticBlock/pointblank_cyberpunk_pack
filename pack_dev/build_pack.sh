#!/bin/bash

# This script was made so that the items in the content pack are properly sorted in its creative tab. You can easily compress the files without using this script and have the pack working as intended, though the items in the creative inventory will be horribly unorganized.

# Unfortunately, this script might not help with item sorting in Point Blank: Jelly as there seems to be some changes that cause the items to show up in a different order in the creative tab.

# Yes, the base of this was originally written by ChatGPT because I couldn't be bothered to learn enough bash (at the time of creation) to write this myself.

# This script was written for Linux. Windows users might have to use WSL to get this to work or port it to Powershell somehow.

# Change this to whatever you want the pack version to be
pack_version="1.18-WIP1"

# Name of the zip file (Do NOT include any file extensions! That will be handled by the script, mainly because I wanted to be able to build .jar files as well for Pointblank: Jelly)
zip_name="Cyberpunk_2077_Guns_Pack"

# Folder to be zipped (example: "$HOME/Documents/MyVPBPack")
folder_to_zip="$(pwd)"

# Array of weapons to be added (in the order you want) (you don't need to add .json at the end, the script already does this when putting together the archive file)
pistols=("cp2077_arasaka_hjke11_yukimura" "cp2077_arasaka_hjke11_yukimura_genjiroh" "cp2077_arasaka_hjke11_yukimura_skippy" "cp2077_budget_arms_slaughtomatic" "cp2077_ca_liberty" "cp2077_ca_liberty_dex" "cp2077_ca_liberty_padre" "cp2077_ca_liberty_rogue" "cp2077_ca_liberty_yori" "cp2077_ca_unity" "cp2077_ca_unity_angelica" "cp2077_ca_unity_iconic" "cp2077_ha_4grit" "cp2077_ha_4grit_catahoula" "cp2077_malorian_arms_3516" "cp2077_malorian_arms_overture" "cp2077_malorian_arms_overture_cassidy" "cp2077_malorian_arms_overture_dante" "cp2077_malorian_arms_overture_dodger" "cp2077_malorian_arms_overture_kerry" "cp2077_malorian_arms_overture_river" "cp2077_militech_m10af_lexington" "cp2077_militech_m10af_lexington_rook" "cp2077_militech_m10af_lexington_wilson" "cp2077_militech_m10af_lexington_xmod2" "cp2077_militech_ar_lexington" "cp2077_techtronika_metel" "cp2077_techtronika_metel_kurt" "cp2077_techtronika_metel_taigan")

assault_rifles=("cp2077_arasaka_hjsh18_masamune" "cp2077_arasaka_hjsh18_masamune_rogue" "cp2077_arasaka_nowaki" "cp2077_darra_da8_umbra" "cp2077_darra_da8_umbra_paco" "cp2077_darra_da8_umbra_xmod2" "cp2077_militech_hercules_3ax" "cp2077_militech_m251s_ajax" "cp2077_militech_m251s_ajax_barghest" "cp2077_militech_m251s_ajax_moron" "cp2077_nokota_d5_copperhead" "cp2077_nokota_d5_copperhead_psalm" "cp2077_nokota_d5_sidewinder" "cp2077_nokota_d5_sidewinder_dws" "cp2077_tsunami_kyubi" "cp2077_tsunami_kyubi_chinook" "cp2077_tsunami_kyubi_myers" "cp2077_tsunami_kyubi_xmod2")

smgs=("cp2077_arasaka_senkoh_lx" "cp2077_arasaka_senkoh_lx_proto" "cp2077_kang_tao_g58_dian" "cp2077_kang_tao_g58_dian_yinglong" "cp2077_project_cynosure_erebus")

rifles=("cp2077_militech_m179_achilles" "cp2077_militech_m179_achilles_xmod2" "cp2077_militech_m179_achilles_nash" "cp2077_rostovic_kolac" "cp2077_rostovic_kolac_mike")

snipers=("cp2077_nokota_ndi_osprey" "cp2077_techtronika_spt32_grad" "cp2077_techtronika_spt32_grad_borzaya" "cp2077_techtronika_spt32_grad_buck" "cp2077_techtronika_spt32_grad_panam" "cp2077_techtronika_spt32_grad_sparky" "cp2077_tsunami_nekomata" "cp2077_tsunami_nekomata_breakthrough" "cp2077_tsunami_nekomata_foxhound" "cp2077_tsunami_rasetsu")

shotguns=("cp2077_budget_arms_carnage" "cp2077_budget_arms_carnage_guts" "cp2077_budget_arms_carnage_judy" "cp2077_rostovic_db2_satara" "cp2077_rostovic_db2_satara_brick" "cp2077_rostovic_db2_testera" "cp2077_rostovic_db2_testera_leon" "cp2077_rostovic_db4_igla" "cp2077_rostovic_db4_igla_sovereign" "cp2077_rostovic_db4_palica")

lmgs=("cp2077_ca_m2067_defender" "cp2077_ca_m2067_defender_kurt")

melees=("cp2077_fang" "cp2077_katana" "cp2077_katana_e3" "cp2077_katana_saburo" "cp2077_katana_wakako" "cp2077_tomahawk" "cp2077_tomahawk_agaou")

attachments=("cp2077_cqo_kanone_mini_mk72" "cp2077_kanetsugu" "cp2077_os1_gimleteye" "cp2077_type_2067" "cp2077_clearvue_mk8" "cp2077_e255_percipient" "cp2077_e255_percipient_blue" "cp2077_mk2x_grandstand" "cp2077_so21_saika" "cp2077_e305_prospecta" "cp2077_gaki" "cp2077_gaki_red" "cp2077_hpo_kanone_max_mk77" "cp2077_hpo_kanone_max_mk77_tan" "cp2077_xc_10_cetus" "cp2077_xc_10_strix" "cp2077_chimera_core" "cp2077_chimera_firecracker" "cp2077_chimera_focus" "cp2077_chimera_overclocker" "cp2077_chimera_sharpshooter" "cp2077_tsunami_rasetsu_suppressor" "cp2077_skin_military" "cp2077_skin_neon" "cp2077_skin_pimp" "cp2077_hypercritical_red_skin")

misc=("cp2077_cerberus_behavioral_system" "cp2077_cerberus_behavioral_system_decoded")

# Full name of the new archive (I RECOMMEND YOU DON'T TOUCH THIS!)
zip_full_name="${zip_name}_${pack_version}.zip"

# File extension the script will look for (I RECOMMEND YOU DON'T TOUCH THIS!)
file_extension=".json"

# Directory inside the zip where new files will be added (I RECOMMEND YOU DON'T TOUCH THIS!)
zip_directory="assets/pointblank/items"

# The directory of the subfolder that will be used to re-insert the item files (I RECOMMENDED YOU DON'T TOUCH THIS!)
folder_subdir="$folder_to_zip/$zip_directory"

# Zip everything together
echo "Zipping pack together..."
(cd "$folder_to_zip" && zip -urq "$zip_full_name" ./* -x '*.zip' '*.sh' 'fabric.mod.json' 'META-INF' 'icon.png') # Exclude zip files and the build script itself (also exclude some PB:J related JAR files)

# Gets rid of everything inside "assets/pointblank/items" so the items can be re-inserted into the right order
echo "Deleting the items because they are unorganized... (Don't worry, they'll be re-inserted back into the archive in the order you specified!)"
zip --delete -q "$zip_full_name" "$zip_directory/*"

# Re-insert all of the weapons back into the archive
echo "Re-inserting Pistols..."
for file in "${pistols[@]}"; do
    full_file_name="${folder_subdir}/${file}${file_extension}"
    if [ -f "$full_file_name" ]; then
        echo "  Zipping $file..."
        zip -urq "$zip_full_name" "$zip_directory/${file}${file_extension}"
    else
        echo "WARNING: the pistol \"${file}${file_extension}\" does not exist!"
    fi
done

echo "Re-inserting Assault Rifles..."
for file in "${assault_rifles[@]}"; do
    full_file_name="${folder_subdir}/${file}${file_extension}"
    if [ -f "$full_file_name" ]; then
        echo "  Zipping $file..."
        zip -urq "$zip_full_name" "$zip_directory/${file}${file_extension}"
    else
        echo "WARNING: the assault rifle \"${file}${file_extension}\" does not exist!"
    fi
done

echo "Re-inserting SMGs..."
for file in "${smgs[@]}"; do
    full_file_name="${folder_subdir}/${file}${file_extension}"
    if [ -f "$full_file_name" ]; then
        echo "  Zipping $file..."
        zip -urq "$zip_full_name" "$zip_directory/${file}${file_extension}"
    else
        echo "WARNING: the SMG \"${file}${file_extension}\" does not exist!"
    fi
done

echo "Re-inserting Rifles..."
for file in "${rifles[@]}"; do
    full_file_name="${folder_subdir}/${file}${file_extension}"
    if [ -f "$full_file_name" ]; then
        echo "  Zipping $file..."
        zip -urq "$zip_full_name" "$zip_directory/${file}${file_extension}"
    else
        echo "WARNING: the rifle \"${file}${file_extension}\" does not exist!"
    fi
done

echo "Re-inserting Sniper rifles..."
for file in "${snipers[@]}"; do
   full_file_name="${folder_subdir}/${file}${file_extension}"
    if [ -f "$full_file_name" ]; then
        echo "  Zipping $file..."
        zip -urq "$zip_full_name" "$zip_directory/${file}${file_extension}"
    else
        echo "WARNING: the sniper rifle \"${file}${file_extension}\" does not exist!"
    fi
done

echo "Re-inserting Shotguns..."
for file in "${shotguns[@]}"; do
    full_file_name="${folder_subdir}/${file}${file_extension}"
    if [ -f "$full_file_name" ]; then
        echo "  Zipping $file..."
        zip -urq "$zip_full_name" "$zip_directory/${file}${file_extension}"
    else
        echo "WARNING: the shotgun \"${file}${file_extension}\" does not exist!"
    fi
done

echo "Re-inserting LMGs..."
for file in "${lmgs[@]}"; do
    full_file_name="${folder_subdir}/${file}${file_extension}"
    if [ -f "$full_file_name" ]; then
        echo "  Zipping $file..."
        zip -urq "$zip_full_name" "$zip_directory/${file}${file_extension}"
    else
        echo "WARNING: the LMG \"${file}${file_extension}\" does not exist!"
    fi
done

echo "Re-inserting Melee weapons..."
for file in "${melees[@]}"; do
    full_file_name="${folder_subdir}/${file}${file_extension}"
    if [ -f "$full_file_name" ]; then
        echo "  Zipping $file..."
        zip -urq "$zip_full_name" "$zip_directory/${file}${file_extension}"
    else
        echo "WARNING: the melee weapon \"${file}${file_extension}\" does not exist!"
    fi
done

echo "Re-inserting Attachments..."
for file in "${attachments[@]}"; do
    full_file_name="${folder_subdir}/${file}${file_extension}"
    if [ -f "$full_file_name" ]; then
        echo "  Zipping $file..."
        zip -urq "$zip_full_name" "$zip_directory/${file}${file_extension}"
    else
        echo "WARNING: the attachment \"${file}${file_extension}\" does not exist!"
    fi
done

echo "Re-inserting Misc items..."
for file in "${misc[@]}"; do
    full_file_name="${folder_subdir}/${file}${file_extension}"
    if [ -f "$full_file_name" ]; then
        echo "  Zipping $file..."
        zip -urq "$zip_full_name" "$zip_directory/${file}${file_extension}"
    else
        echo "WARNING: the misc item \"${file}${file_extension}\" does not exist!"
    fi
done

# My abominable attempt at making the .jar file while keeping the modloader stuff out of the regular zip archive
if [ $1 == "-jar" ] 2> /dev/null; then
    echo "INFO: Creating .jar file for use with Pointblank: Jelly."
    zip -urq "$zip_full_name" "fabric.mod.json"
    zip -urq "$zip_full_name" "icon.png"
    zip -urq "$zip_full_name" "META-INF"
    zip -urq "$zip_full_name" "META-INF/neoforge.mods.toml"
    cp "$folder_to_zip"/"$zip_full_name" "$folder_to_zip"/"$zip_name""_PBJ.jar"
    zip -d "$zip_full_name" "fabric.mod.json"
    zip -d "$zip_full_name" "icon.png"
    zip -d "$zip_full_name" "META-INF/neoforge.mods.toml"
    zip -d "$zip_full_name" "META-INF"
fi

echo ""
echo "WARNING: Item order may not work in Point Blank: Jelly!"
echo ""
echo "Done! Output file should be named \"$zip_full_name\" and placed in the same spot as this script."

if [ $1 == "-jar" ] 2> /dev/null; then
    echo ""
    echo "Additionally, the .jar version of the archive \"$zip_name""_PBJ.jar\" has been created in the same space."
fi


# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name ncas1000 -dir "E:/MyProjects/STV/1000x/in_board/par/ncas1000/planAhead_run_2" -part xc7k160tffg676-2
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "E:/MyProjects/STV/1000x/in_board/par/ncas1000/ncas1000_top.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {E:/MyProjects/STV/1000x/in_board/par/ncas1000} }
set_property target_constrs_file "E:/MyProjects/STV/1000x/in_board/src/top/ncas1000_top.ucf" [current_fileset -constrset]
add_files [list {E:/MyProjects/STV/1000x/in_board/src/top/ncas1000_top.ucf}] -fileset [get_property constrset [current_run]]
link_design

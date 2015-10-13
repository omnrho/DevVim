PROFILESLIST=$(shell find models -maxdepth 1 -type d -printf "%f " | sed "s/\.svn//" | sed "s/\.//" | sed "s/models//")
TOPDIR=$(shell pwd)
KERNEL_TAG_DIR=$(TOPDIR)/TAGDIR/kernel
MAPP_TAG_DIR=$(TOPDIR)/TAGDIR/mapps
-include Profile.mak

all: profile linux mapps
	@echo "export TOPDIR=$(TOPDIR)" > $(TOPDIR)/trace_p.sh 
	@echo "export BRAND_NAME=$(BRAND_NAME)" >> $(TOPDIR)/trace_p.sh 
	@echo "export MODEL_NAME=$(MODEL_NAME)" >> $(TOPDIR)/trace_p.sh 
	@echo "export SPEC_NAME=$(SPEC_NAME)" >> $(TOPDIR)/trace_p.sh 
	@echo "export MODEL_DIR=$(MODEL_DIR)" >> $(TOPDIR)/trace_p.sh 
	@echo "export PROFILE_DIR=$(PROFILE_DIR)" >> $(TOPDIR)/trace_p.sh 
	@echo "export MODEL_APP_DIR=$(MODEL_APP_DIR)" >> $(TOPDIR)/trace_p.sh 
	@echo "export MODEL_DRV_DIR=$(MODEL_DRV_DIR)" >> $(TOPDIR)/trace_p.sh 
	@echo "export ARCH=$(ARCH)" >> $(TOPDIR)/trace_p.sh 
	@echo "export BSPDIR=$(BSPDIR)" >> $(TOPDIR)/trace_p.sh 
	@echo "export PATH=$(HOME)/bin:$(PATH)" >> $(TOPDIR)/trace_p.sh 
#	@echo "export CROSS_COMPILE=$(CROSS_COMPILE)" >> $(TOPDIR)/trace_p.sh 
#	@echo "export CC=$(CC)" >> $(TOPDIR)/trace_p.sh 
#	@echo "export LD=$(LD)" >> $(TOPDIR)/trace_p.sh 
#	@echo "export AR=$(AR)" >> $(TOPDIR)/trace_p.sh 
#	@echo "export STRIP=$(STRIP)" >> $(TOPDIR)/trace_p.sh 
#	@echo "export RANLIB=$(RANLIB)" >> $(TOPDIR)/trace_p.sh 
#	@echo "export CXX=$(CXX)" >> $(TOPDIR)/trace_p.sh 
	@echo "export KERNELDIR=$(KERNELDIR)" >> $(TOPDIR)/trace_p.sh 
	@echo "export BOOTDIR=$(BOOTDIR)" >> $(TOPDIR)/trace_p.sh 
	@echo "export FSDIR=$(FSDIR)" >> $(TOPDIR)/trace_p.sh 
	@echo "export ROOTDIR=$(ROOTDIR)" >> $(TOPDIR)/trace_p.sh 
	@echo "export BSPROOTDIR=$(BSPROOTDIR)" >> $(TOPDIR)/trace_p.sh 
	@echo "export IMAGESDIR=$(IMAGESDIR)" >> $(TOPDIR)/trace_p.sh 
	@echo "export BSPIMAGESDIR=$(BSPIMAGESDIR)" >> $(TOPDIR)/trace_p.sh 
	@echo "export IMAGESINSTALLDIR=$(IMAGESINSTALLDIR)" >> $(TOPDIR)/trace_p.sh 
	@echo "export TOOLSDIR=$(TOOLSDIR)" >> $(TOPDIR)/trace_p.sh 
	@echo "export APPSDIR=$(APPSDIR)" >> $(TOPDIR)/trace_p.sh 
	@echo "export ONUDIR=$(ONUDIR)" >> $(TOPDIR)/trace_p.sh 
	@echo "export DRVSDIR=$(DRVSDIR)" >> $(TOPDIR)/trace_p.sh 
	@echo "export ISOLINUXDIR=$(ISOLINUXDIR)" >> $(TOPDIR)/trace_p.sh 
	@echo "export GPLDIR=$(GPLDIR)" >> $(TOPDIR)/trace_p.sh 
	@echo "export GPLAPPDIR=$(GPLAPPDIR)" >> $(TOPDIR)/trace_p.sh 
	@echo "export GPLDRVDIR=$(GPLDRVDIR)" >> $(TOPDIR)/trace_p.sh 
	@echo "export GPL_MODEL_DIR=$(GPL_MODEL_DIR)" >> $(TOPDIR)/trace_p.sh 
	@echo "export GPL_MODEL_TOP_DIR=$(GPL_MODEL_TOP_DIR)" >> $(TOPDIR)/trace_p.sh 
	@echo "export GPL_PROFILE_DIR=$(GPL_PROFILE_DIR)" >> $(TOPDIR)/trace_p.sh 
	@echo "export GPL_MODEL_APP_DIR=$(GPL_MODEL_APP_DIR)" >> $(TOPDIR)/trace_p.sh 
	@echo "export GPL_MODEL_DRV_DIR=$(GPL_MODEL_DRV_DIR)" >> $(TOPDIR)/trace_p.sh 
	@echo "alias cda='cd $(MODEL_APP_DIR)'" >> $(TOPDIR)/trace_p.sh
	@echo "alias cdb='cd $(BSPDIR)'" >> $(TOPDIR)/trace_p.sh
	@echo "alias cdt='cd $(TOPDIR)'" >> $(TOPDIR)/trace_p.sh
	@echo "alias cdr='cd $(BSPROOTDIR)'" >> $(TOPDIR)/trace_p.sh
	@echo "alias cdfw='cd $(BSPIMAGESDIR)'" >> $(TOPDIR)/trace_p.sh
	@echo "alias cdk='cd $(KERNELDIR)'" >> $(TOPDIR)/trace_p.sh
	@echo "alias cdm='cd $(MODEL_DIR)'" >> $(TOPDIR)/trace_p.sh
	@cat $(TOPDIR)/trace_p.sh|cut -d" " -f 2-
profile:
	@echo -ne "\nMake check first only!!\n"
	@if [ -f Profile.mak ] ; then\
		BRAND_NAME=`awk -F = '/BRAND_NAME=/{print $$2}' Profile.mak`;\
		MODEL_NAME=`awk -F = '/MODEL_NAME=/{print $$2}' Profile.mak`;\
		SPEC_NAME=`awk -F = '/SPEC_NAME=/{print $$2}' Profile.mak`;\
		VERSION_STRING=`awk -F = '/VERSION_STRING=/{print $$2}' Profile.mak`;\
		FLASH_SIZE=`awk -F = '/FLASH_SIZE=/{print $$2}' Profile.mak`;\
		RAM_SIZE=`awk -F = '/RAM_SIZE=/{print $$2}' Profile.mak`;\
		echo -ne "\nThe current profile selected is: $${BRAND_NAME}_$${MODEL_NAME}_$${SPEC_NAME}\n\n  BRAND_NAME=$$BRAND_NAME MODEL_NAME=$$MODEL_NAME SPEC_NAME=$$SPEC_NAME VERSION_STRING=$$VERSION_STRING FLASH_SIZE=$$FLASH_SIZE RAM_SIZE=$$RAM_SIZE\n\n";\
		echo -ne "make with current profile?\n\n";\
		echo -ne "press "Return" key to make with current profile or enter "n" to select another profile. ";\
		read go;\
		if [ "$$go" == "n" ]; then\
			create_profile=1;\
		else\
			eval nowsel=\$${BRAND_NAME}_\$${MODEL_NAME}_\$${SPEC_NAME};\
			create_profile=0;\
			TOP=$(shell pwd)/profiles/$$nowsel/top.mak;\
			if [ -f $$TOP ] ; then\
				echo -ne "";\
			else\
				TOP=$(shell pwd)/models/$$nowsel/profiles/top.mak;\
			fi;\
		fi;\
	else\
		create_profile=1;\
	fi;\
	if [ "$$create_profile" == "1" ] ; then\
		echo -ne "\nPlease select the profile to make first... \n\n";\
		echo -ne "The profiles available are:\n\n";\
		count=0;\
		for i in $(PROFILESLIST) ; do\
			profile_list=$(shell pwd)/profiles/$$i/Profile.mak;\
			if [ -f $$profile_list ] ; then\
				echo -ne "";\
			else\
				profile_list=$(shell pwd)/models/$$i/profiles/Profile.mak;\
			fi;\
			eval profile$$count=$$i;\
			eval BRAND_NAME$$count=`awk -F = '/BRAND_NAME=/{print $$2}' $$profile_list`;\
			eval MODEL_NAME$$count=`awk -F = '/MODEL_NAME=/{print $$2}' $$profile_list`;\
			eval SPEC_NAME$$count=`awk -F = '/SPEC_NAME=/{print $$2}' $$profile_list`;\
			eval VERSION_STRING$$count=`awk -F = '/VERSION_STRING=/{print $$2}' $$profile_list`;\
			eval FLASH_SIZE$$count=`awk -F = '/FLASH_SIZE=/{print $$2}' $$profile_list`;\
			eval RAM_SIZE$$count=`awk -F = '/RAM_SIZE=/{print $$2}' $$profile_list`;\
			eval "echo -ne \"$$count: \$$BRAND_NAME$$count\"\"_\$$MODEL_NAME$$count\"\"_\$$SPEC_NAME$$count\"\"\n\"";\
			eval "echo -ne \"$${count/*/ }  BRAND_NAME=\$$BRAND_NAME$$count\"\"  MODEL_NAME=\$$MODEL_NAME$$count\"\"  SPEC_NAME=\$$SPEC_NAME$$count\"\"  VERSION_STRING=\$$VERSION_STRING$$count\"\"  FLASH_SIZE=\$$FLASH_SIZE$$count\"\"  RAM_SIZE=\$$RAM_SIZE$$count\"  \"\n\n\"";\
			count=`expr $$count + 1`;\
		done;\
		count=`expr $$count - 1`;\
		echo -ne "Please select from 0 to $$count... ";\
		read profilesel;\
		if [ -z "$${profilesel##[0-9]*}" ] && [ "$$profilesel" -ge "0" ] && [ "$$profilesel" -le "$$count" ] ; then\
			eval nowsel=\$$profile$$profilesel;\
			oldsel=`cat selection`;\
			PROFILE=$(shell pwd)/profiles/$$nowsel/Profile.mak;\
			if [ -f $$PROFILE ] ; then \
				TOP=$(shell pwd)/profiles/$$nowsel/top.mak;\
			else\
				PROFILE=$(shell pwd)/models/$$nowsel/profiles/Profile.mak;\
				TOP=$(shell pwd)/models/$$nowsel/profiles/top.mak;\
			fi;\
			ln -sf $$PROFILE;\
			if [ "$$oldsel" != "" ] && [ "$$nowsel" != "$$oldsel" ] ; then\
				make -i -f $$TOP distclean;\
			fi;\
			ln -sf $$PROFILE;\
			eval "echo \"\$$profile$$profilesel\" > selection";\
		fi;\
	fi;\

linux:
	mkdir -p $(KERNEL_TAG_DIR)
	find -L $(KERNELDIR) \( -name '*.o' -o -name '*.ko' \) -print | xargs -i dirname  '{}'|sort |uniq > $(KERNEL_TAG_DIR)/kernel_used_dir	
	cat $(KERNEL_TAG_DIR)/kernel_used_dir |xargs -i find -L '{}' -maxdepth 1  -name 'include' > $(KERNEL_TAG_DIR)/kernel_include_dir
	cat $(KERNEL_TAG_DIR)/kernel_include_dir |xargs -i find -L '{}' -name '*.h' > $(KERNEL_TAG_DIR)/kernel_used_files_0
	cat $(KERNEL_TAG_DIR)/kernel_used_dir |xargs -i find -L '{}' -maxdepth 1  -name '*.[chsS]' >>  $(KERNEL_TAG_DIR)/kernel_used_files_0
	cat $(KERNEL_TAG_DIR)/kernel_used_files_0 |sort |uniq > $(KERNEL_TAG_DIR)/kernel_used_files && rm $(KERNEL_TAG_DIR)/kernel_used_files_0
	cd $(KERNEL_TAG_DIR) && cscope -bkq -i $(KERNEL_TAG_DIR)/kernel_used_files
	cd $(KERNEL_TAG_DIR) && ctags --c++-kinds=+p --fields=+iaS --links=yes --extra=+q -L $(KERNEL_TAG_DIR)/kernel_used_files

mapps:
	mkdir -p $(MAPP_TAG_DIR)
	find -L $(APPSDIR) \( -name '*.o' -o -name '*.ko' \) -print | xargs -i dirname  '{}'|sort |uniq > $(MAPP_TAG_DIR)/apps_used_dir	
	cat $(MAPP_TAG_DIR)/apps_used_dir |xargs -i find -L '{}' -maxdepth 1  -name 'include' > $(MAPP_TAG_DIR)/apps_include_dir
	cat $(MAPP_TAG_DIR)/apps_include_dir |xargs -i find -L '{}' -name '*.h' > $(MAPP_TAG_DIR)/apps_used_files_0
	cat $(MAPP_TAG_DIR)/apps_used_dir |xargs -i find -L '{}' -maxdepth 1  -name '*.[chsS]' >>  $(MAPP_TAG_DIR)/apps_used_files_0
	find $(MODEL_APP_DIR) -name "*.[chS]" -print >> $(MAPP_TAG_DIR)/apps_used_files_0
	cat $(MAPP_TAG_DIR)/apps_used_files_0 |sort |uniq > $(MAPP_TAG_DIR)/apps_used_files && rm $(MAPP_TAG_DIR)/apps_used_files_0
	cd $(MAPP_TAG_DIR) && cscope -bkq -i $(MAPP_TAG_DIR)/apps_used_files
	cd $(MAPP_TAG_DIR) && ctags --c++-kinds=+p --fields=+iaS --links=yes --extra=+q -L $(MAPP_TAG_DIR)/apps_used_files

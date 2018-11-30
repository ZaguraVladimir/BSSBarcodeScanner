LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := com_BSS_BarcodeScanner
LOCAL_LDLIBS := -llog
LOCAL_CFLAGS += -fexceptions

LOCAL_C_INCLUDES += $(LOCAL_PATH) $(LOCAL_PATH)../../INCLUDE
LOCAL_SRC_FILES := \
    jnienv.cpp \
    ../cpp/AddInNative.cpp \
    ../cpp/StepCounter.cpp \
    ../cpp/ConversionWchar.cpp \
    ../cpp/dllmain.cpp \
    ../cpp/stdafx.cpp

include $(BUILD_SHARED_LIBRARY)

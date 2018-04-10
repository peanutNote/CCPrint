#ifndef __PROCESS_H__
#define    __PROCESS_H__


#ifdef __cplusplus
extern "C" {
#endif
    
    
    /**
     * 打印机信息
     */
    typedef struct {
        int instruct_type;
        int dpi;
        int io;
    } MPPrinter;
    
    /**
     * 预处理任务
     */
#define URI_NONE 0
#define URI_IMAGE 1
    
    typedef struct {
        int uri_type;  // 资源文件类型
        char *kvalue;  // 资源文件描述符
    } MPURIVal;
    
    /**
     * 打印结果
     */
    typedef struct {
        int ret;  // 处理结果
        int result_len;  // 指令长度
        char *result;  // 具体发送给打印机的指令内容
    } MPInsRsl;
    
    /**
     * 图像
     */
    typedef struct {
        int w;  // 图像宽
        int h;  // 图像高
        char *data;  // 图像数据
    } MPBitmap;
    
    /**
     * 初始化处理器
     */
    int __attribute__((visibility("default"))) mp_init(const char *tpl, int tpl_len, MPPrinter pinfo);
    
    /**
     * 提取URI资源文件
     */
    MPURIVal __attribute__((visibility("default"))) mp_extract_uri(void);
    
    /**
     * 设置资源文件名称
     */
    void __attribute__((visibility("default"))) mp_set_uri_image(char *kvalue, MPBitmap bitmap);
    
    /**
     * 预打印
     */
    MPInsRsl __attribute__((visibility("default"))) mp_pre_print(void);
    
    /**
     * 预打印：能用结构体返回的用结构体
     */
    int __attribute__((visibility("default"))) mp_pre_print_p(char **buffer);
    
    /**
     * 预览
     */
    MPBitmap __attribute__((visibility("default"))) mp_preview(void);
    
    /**
     * 预览：能用结构体返回的用结构体
     */
    MPBitmap *__attribute__((visibility("default"))) mp_preview_p(void);
    
    /**
     * 清除处理器
     */
    void __attribute__((visibility("default"))) mp_clear(void);
    
    
#ifdef __cplusplus
}
#endif


#endif // !__PROCESS_H__


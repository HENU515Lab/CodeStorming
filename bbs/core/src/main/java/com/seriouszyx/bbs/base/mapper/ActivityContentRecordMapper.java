package com.seriouszyx.bbs.base.mapper;

import com.seriouszyx.bbs.base.domain.ActivityContentRecord;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface ActivityContentRecordMapper {
    int deleteByPrimaryKey(Long id);

    ActivityContentRecord selectByPrimaryKey(Long id);

    List<ActivityContentRecord> selectAll();

    int updateByPrimaryKey(ActivityContentRecord record);

    ActivityContentRecord selectActivityContentRecord(@Param("userId") Long userId,
                                                      @Param("activityContentId") Long activityContentId);

    void insertRecord(@Param("userId") Long userId,
                      @Param("activityContentId") Long activityContentId,
                      @Param("filePath") String filePath,
                      @Param("createTime") Date createTime);

    void updateRecord(@Param("userId") Long userId,
                      @Param("activityContentId") Long activityContentId,
                      @Param("filePath") String filePath);

    List<ActivityContentRecord> selectRecordList(@Param("activityId") Long activityId);
}
package org.zerock.mapper;

import org.omg.CORBA.PUBLIC_MEMBER;
import org.zerock.domain.ReplyVO;

public interface ReplyMapper {

    public int insert(ReplyVO vo);
    public ReplyVO read(Long bno);
    public int delete(Long rno);
    public int update(ReplyVO vo);



}

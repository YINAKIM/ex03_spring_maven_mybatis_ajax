package org.zerock.controller;

import lombok.extern.log4j.Log4j;
import org.apache.commons.fileupload.util.LimitedInputStream;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.SampleVO;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;


@RestController
@RequestMapping("/sample")
@Log4j
public class SampleController {


    // produces = "MIME 타입(보내는 자원의 Content-Type) 지정"  ---> 생략가능
    @GetMapping(value = "/getText",produces = "text/plain; charset=UTF-8")
    public String getText(){
        log.info("MIME TYPE을 알려줘 : "+ MediaType.TEXT_PLAIN_VALUE);
        return "안녕하세요";
    }

    @GetMapping(value = "/getSample"
            ,produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
    public SampleVO getSample(){
        return new SampleVO(112,"스타","로드");

        //http://localhost:8000/sample/getSample -> {"mno":112,"firstName":"스타","lastName":"로드"}
        //
    }

    @GetMapping(value = "/getSample2")
    public SampleVO getSample2(){
        log.info("getSample2!!!!");
        return new SampleVO(113,"로켓","라쿤");

    }



    //컬렉션 타입의 객체 반환
    @GetMapping(value = "/getList")
    public List<SampleVO> getList(){
        return IntStream.range(1,10)
                .mapToObj(i->new SampleVO(i,i+"First",i+"Last")
        ).collect(Collectors.toList());
        /*

        IntStream
        .range(1,10) ---> 1~9로 범위 지정
        .mapToObj(   ---> int스트림(원시스트림)을 객체스트림으로, 누적시킨 최종값을 반환
           i->new SampleVO(i,i+"First",i+"Last")
        )
        .collect(
           Collectors.toList()  ---> list에 최종 결과를 누적시킴
        )

      내부적으로 1~9까지 루프를 처리하면서 SampleVO를 만들고, List<SampleVO>로 만들어냄
      ===> URI에 .json형태로 처리하면 JSON형태의 []로 보임 (JSON배열)

      http://localhost:8004/sample/getList.json 요청

      [   {"mno":1,"firstName":"1First","lastName":"1Last"}
         ,{"mno":2,"firstName":"2First","lastName":"2Last"}
         ,{"mno":3,"firstName":"3First","lastName":"3Last"}
         ,{"mno":4,"firstName":"4First","lastName":"4Last"}
         ,{"mno":5,"firstName":"5First","lastName":"5Last"}
         ,{"mno":6,"firstName":"6First","lastName":"6Last"}
         ,{"mno":7,"firstName":"7First","lastName":"7Last"}
         ,{"mno":8,"firstName":"8First","lastName":"8Last"}
         ,{"mno":9,"firstName":"9First","lastName":"9Last"}  ]

         */
    }



}

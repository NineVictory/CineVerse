package kr.spring.myPage.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.admin.vo.EventVO;
import kr.spring.assignment.vo.AssignVO;
import kr.spring.board.vo.BoardCommentVO;
import kr.spring.board.vo.BoardFavVO;
import kr.spring.board.vo.BoardVO;
import kr.spring.event.vo.UserEventVO;
import kr.spring.member.vo.CouponVO;
import kr.spring.movie.vo.MovieBookMarkVO;
import kr.spring.movie.vo.MovieBookingVO;
import kr.spring.movie.vo.MovieReviewVO;
import kr.spring.myPage.dao.MyPageMapper;
import kr.spring.myPage.vo.MyPageVO;
import kr.spring.support.vo.ConsultVO;

@Service
@Transactional
public class MyPageServiceImpl implements MyPageService{

	@Autowired
	MyPageMapper myPageMapper;

	@Override
	public MyPageVO selectMember(long mem_num) {
		return myPageMapper.selectMember(mem_num);
	}

	@Override
	public Integer selectMemberCoupon(long mem_num) {
		Integer coupon = myPageMapper.selectMemberCoupon(mem_num);
		return coupon != null ? coupon : 0;
	}
	
	@Override
	public List<MyPageVO> selectMemCouponList(Map<String, Object> map) {
		return myPageMapper.selectMemCouponList(map);
	}

	@Override
	public List<BoardVO> selectMemcBoardWriteList(Map<String, Object> map) {
		return myPageMapper.selectMemcBoardWriteList(map);
	}

	@Override
	public Integer cBoardWriteListcnt(Map<String, Object> map) {
		return myPageMapper.cBoardWriteListcnt(map);
	}
	@Override
	public Integer pointHistoryCnt(long mem_num) {
		return myPageMapper.pointHistoryCnt(mem_num);
	}

	@Override
	public List<MyPageVO> selectMemPointList(Map<String, Object> map) {
		return myPageMapper.selectMemPointList(map);
	}

	@Override
	public void updatePassword(MyPageVO mypage) {
		myPageMapper.updatePassword(mypage);
	}

	@Override
	public List<BoardCommentVO> cBoardReplyList(Map<String, Object> map) {
		return myPageMapper.cBoardReplyList(map);
	}

	@Override
	public Integer cBoardReplyListcnt(Map<String, Object> map) {
		return myPageMapper.cBoardReplyListcnt(map);
	}

	@Override
	public void updateMember_detail(MyPageVO mypage) {
		myPageMapper.updateMember_detail(mypage);
	}

	@Override
	public void updateProfile(MyPageVO myPageVO) {
		myPageMapper.updateProfile(myPageVO);
	}

	@Override
	public Integer aBoardListcnt(Map<String, Object> map) {
		return myPageMapper.aBoardListcnt(map);
	}

	@Override
	public List<AssignVO> aBoardList(Map<String, Object> map) {
		return myPageMapper.aBoardList(map);
	}


	@Override
	public List<AssignVO> aBoardBookMarkList(Map<String, Object> map) {
		return myPageMapper.aBoardBookMarkList(map);
	}

	@Override
	public Integer aBoardBookMark(Map<String, Object> map) {
		return myPageMapper.aBoardBookMark(map);
	}

	@Override
	public Integer cBoardBookMark(Map<String, Object> map) {
		return myPageMapper.cBoardBookMark(map);
	}

	@Override
	public List<BoardVO> cBoardBookMarkList(Map<String, Object> map) {
		return myPageMapper.cBoardBookMarkList(map);
	}

	@Override
	public Integer cBoardWriteFavCnt(Map<String, Object> map) {
		return myPageMapper.cBoardWriteFavCnt(map);
	}

	@Override
	public List<BoardFavVO> cBoardWriteFavList(Map<String, Object> map) {
		return myPageMapper.cBoardWriteFavList(map);
	}

	@Override
	public Integer cBoardResponsecnt(Map<String, Object> map) {
		return myPageMapper.cBoardResponsecnt(map);
	}

	@Override
	public List<BoardCommentVO> cBoardResponseList(Map<String, Object> map) {
		return myPageMapper.cBoardResponseList(map);
	}

	@Override
	public Integer movieBookMarkcnt(Long mem_num) {
		return myPageMapper.movieBookMarkcnt(mem_num);
	}

	@Override
	public List<MovieBookMarkVO> movieBookMarkList(Long mem_num) {
		return myPageMapper.movieBookMarkList(mem_num);
	}

	@Override
	public void updateMembership(Long mem_num) {
		myPageMapper.updateMembership(mem_num);
	}

	@Override
	public void insertMembership(Long mem_num) {
		myPageMapper.insertMembership(mem_num);
	}

	@Override
	public void usePoint(Long mem_num) {
		myPageMapper.usePoint(mem_num);
	}

	@Override
	public void insertNewMemCoupon(CouponVO coupon) {
		myPageMapper.insertNewMemCoupon(coupon);
	}

	@Override
	public List<Long> selectInitialCoupons() {
		return myPageMapper.selectInitialCoupons();
	}

	@Override
	public CouponVO selectMembershipSub(Long mem_num) {
		return myPageMapper.selectMembershipSub(mem_num);
	}

	@Override
	public Integer consultcnt(Map<String, Object> map) {
		return myPageMapper.consultcnt(map);
	}

	@Override
	public List<ConsultVO> consultList(Map<String, Object> map) {
		return myPageMapper.consultList(map);
	}

	@Override
	public ConsultVO lastConsert(Long mem_num) {
		return myPageMapper.lastConsert(mem_num);
	}

	@Override
	public void updateNoSub() {
		myPageMapper.updateNoSub();
	}

	@Override
	public void updateNoSubDate() {
		myPageMapper.updateNoSubDate();
	}

	@Override
	public Integer eventcnt(Map<String, Object> map) {
		return myPageMapper.eventcnt(map);
	}

	

	@Override
	public Integer reservationCnt(Map<String, Object> map) {
		return myPageMapper.reservationCnt(map);
	}

	@Override
	public List<MovieBookingVO> reservationList(Long mem_num) {
		return myPageMapper.reservationList(mem_num);
	}


	@Override 
	public List<MovieBookingVO> lastRes(Long mem_num) { 
		return  myPageMapper.lastRes(mem_num); 
	}

	@Override
	public void updateCoupon(Long mem_num) {
		myPageMapper.updateCoupon(mem_num);
	}

	@Override
	public void updatePoint(Long mem_num) {
		myPageMapper.updatePoint(mem_num);
	}

	@Override
	public MovieBookingVO mainRes(Long mem_num) {
		return myPageMapper.mainRes(mem_num);
	}

	@Override
	public Integer movieReviewCnt(Long mem_num) {
		return myPageMapper.movieReviewCnt(mem_num);
	}

	@Override
	public List<MovieReviewVO> movieReviewList(Long mem_num) {
		return myPageMapper.movieReviewList(mem_num);
	}

	@Override
	public void delMovieRev(Long mr_num) {
		myPageMapper.delMovieRev_fav(mr_num);
		myPageMapper.delMovieRev(mr_num);
	}
	
	@Override
	public List<MovieBookingVO> watchedMovList(Map<String, Object> map) {
		return myPageMapper.watchedMovList(map);
	}

	@Override
	public Integer watMovieCnt(Map<String, Object> map) {
		return myPageMapper.watMovieCnt(map);
	}

	@Override
	public Integer resDetailCnt(Long mem_num) {
		return myPageMapper.resDetailCnt(mem_num);
	}

	@Override
	public MovieBookingVO resDetail(Long mb_num) {
		return myPageMapper.resDetail(mb_num);
	}

	@Override
	public List<MovieBookingVO> selectRow(Long mb_num) {
		return myPageMapper.selectRow(mb_num);
	}

	@Override
	public List<MovieBookingVO> selectColumn(Long mb_num) {
		return myPageMapper.selectColumn(mb_num);
	}

	@Override
	public Integer mdCount(Long mb_num) {
		return myPageMapper.mdCount(mb_num);
	}

	@Override
	public Integer selectPayCouponCnt(Long mem_num) {
		return myPageMapper.selectPayCouponCnt(mem_num);
	}

	@Override
	public MyPageVO selectCouponPrice(Long mem_coupon_use) {
		return myPageMapper.selectCouponPrice(mem_coupon_use);
	}

	@Override
	public List<UserEventVO> eventList(Map<String, Object> map) {
		return myPageMapper.eventList(map);
	}

	@Transactional
    @Override
    public void deleteOrders(Long mem_num) {
        myPageMapper.deletePbasketmem(mem_num);
        myPageMapper.deletePreview(mem_num);
        myPageMapper.deletePfav(mem_num);
        myPageMapper.deleteOrderdetail(mem_num);
        myPageMapper.deleteOrders(mem_num);
        myPageMapper.deleteaddressmem(mem_num);
    }

    @Transactional
    @Override
    public void deleteMoviebooking(Long mem_num) {
    	myPageMapper.deleteMovieBookmark(mem_num);
    	myPageMapper.deleterrReport(mem_num);
    	myPageMapper.deleteReviewReport(mem_num);
    	myPageMapper.deleteMovieReview(mem_num);
        myPageMapper.deleteMbdetail(mem_num);
        myPageMapper.deleteMoviebooking(mem_num);
    }

    @Transactional
    @Override
    public void deleteCommunityB(Long mem_num) {
    	myPageMapper.deleteCommunityReportA(mem_num);
        myPageMapper.deleteCommunityReport(mem_num);
        myPageMapper.deleteCommentReport(mem_num);
        myPageMapper.deleteCommentReportA(mem_num);
        myPageMapper.deleteResponseReport(mem_num);
        myPageMapper.deleteResponseReportA(mem_num);
        myPageMapper.deleteCommunityResFav(mem_num);
        myPageMapper.deleteCommunityResFavA(mem_num);
        myPageMapper.deleteCommunityComFavA(mem_num);
        myPageMapper.deleteCommunityComFav(mem_num);
        myPageMapper.deleteCommunityFav(mem_num);
        myPageMapper.deleteCommunityFavA(mem_num);
        myPageMapper.deleteCommunityCB(mem_num);
        myPageMapper.deleteCommunityCBA(mem_num);
        myPageMapper.deleteCommunityCR(mem_num);
        myPageMapper.deleteCommunityCRA(mem_num);
        myPageMapper.deleteCommunityCA(mem_num);
        myPageMapper.deleteCommunityC(mem_num);
        myPageMapper.deleteCommunityB(mem_num);
    }

    @Transactional
    @Override
    public void deleteAssignBoard(Long mem_num) {
        myPageMapper.deleteAssingReport(mem_num);
        myPageMapper.deleteAssingReportAll(mem_num);
        myPageMapper.deleteAbmark(mem_num);
        myPageMapper.deleteAbmarkAll(mem_num);
        myPageMapper.deleteAssignBoard(mem_num);
    }

    @Transactional
    @Override
    public void deleteTalkroomByMemNum(Long mem_num) {
        myPageMapper.deleteTalkReadByMemNum(mem_num);
        myPageMapper.deleteTalkReadTN(mem_num);
        myPageMapper.deleteTalkByMemNum(mem_num);
        myPageMapper.deleteTalkTN(mem_num);
        myPageMapper.deleteTalkMemberByMemNum(mem_num);
        myPageMapper.deleteTalkMemTN(mem_num);
        myPageMapper.deleteTalkroomByMemNum(mem_num);
    }

    @Transactional
    @Override
    public void updateMem(Long mem_num) {
        myPageMapper.deleteEventP(mem_num);
        myPageMapper.deleteConsult(mem_num);
        myPageMapper.deleteMemCoupon(mem_num);
        myPageMapper.deleteMemdetail(mem_num);
        myPageMapper.updateMem(mem_num);
    }







}

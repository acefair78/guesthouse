package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	// DB 접속 정보를 저장, 수정,삭제,조회
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";

	// DB 연결메서드
	private Connection getCon() throws Exception {
		// final String DRIVER="com.mysql.jdbc.Driver";
		// final String URL="jdbc:mysql://localhost:3306/jspdb";
		// final String ID = "jspid";
		// final String PW = "jsppass";
		//
		// // 1. 드라이버로 로드
		// Class.forName(DRIVER);
		// // 2. 디비 연결
		// con = DriverManager.getConnection(URL, ID, PW);
		// System.out.println("드라이버 로드 & 디비연결 성공");
		// return con;

		// 커넥션풀 프로그램 설치 
		// WEB-INF -> lib -> 파일 복사 
		// http://commons.apache.org/
		// commons-collections-3.2.1.jar
		// commons-dbcp-1.4.jar
		// commons-pool-1.6.jar
		
		// 1. WebContent -> META-INF -> context.xml 생성
		//  1,2단계 처리파일 -> 디비연동, 이름 정의 
		// 2. WebContent -> WEB-INF -> web.xml파일 수정
		// 3. 해당 DB 작업 처리 (DAO) -> 연결정보의 이름 호출 
		
		//Context 객체 생성
		Context init =new InitialContext();
		// DataSource  디비 연동이름 호출
		DataSource ds =
	    (DataSource)init.lookup("java:comp/env/jdbc/mysqlDB");
		//ds 사용하여 연결정보 저장 
		con = ds.getConnection();
		
		return con;
	}
	// 자원해제 
	public void closeDB(){
	
		try {
			if(rs != null){ rs.close();	}
			if(pstmt != null){pstmt.close();}
			if(con != null){con.close();}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

	// insertBoard(bb)
	public void insertBoard(BoardBean bb) {

		int num=0;
		try {
			con = getCon();
			
			// num  게시판 글번호 계산
			sql ="select max(num) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				num = rs.getInt(1)+1; // 가능
				//num = rs.getInt("num")+1; // 에러
				//num = rs.getInt("max(num)")+1; //가능
			}
			System.out.println("num ="+num);
			
			// sql & pstmt ( 게시글 작성 )
			sql="insert into board("
					+ "num,name,pass,subject,content,"
					+ "readcount,re_ref,re_lev,re_seq,"
					+ "date,ip,file) values("
					+ "?,?,?,?,?,?,"
					+ "?,?,?,now(),?,?)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num); // 계산한 글번호값
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getPass());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, 0); // 글 조회수 0
			pstmt.setInt(7, num); // re_ref 답변글 그룹 == 일반글의 글번호와 동일 
			pstmt.setInt(8, 0); // re_lev 답변글 들여쓰기, 일반글은 들여쓰기 X
			pstmt.setInt(9, 0); // re_seq 답변글 순서, 일반글 순서가 제일 위쪽
			//pstmt.setDate(10, x); //data 정보는 sql 쿼리에서 now() 내장함수 사용 
			pstmt.setString(10, bb.getIp());
			pstmt.setString(11, bb.getFile());
			
			// 4. 실행
			pstmt.executeUpdate();
			
			System.out.println("게시판 "+num+"번 글 작성 완료");
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		
	}
	// insertBoard(bb)
	
	// getBoardCount()
	public int getBoardCount(){
		int count=0;
		try {
			// 디비연결,드라이버로드
			con = getCon();
			
			// SQL 작성
			// 게시판에 있는 글 전체의 개수 count()  
			sql="select count(*) from board";
			pstmt = con.prepareStatement(sql);
			// 실행 
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				count = rs.getInt(1);
			}
			System.out.println("작성된 글 수 :"+count);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
      return count;		
	}
	// getBoardCount()

	// getBoardList()
	public List getBoardList(){
		List boardList = new ArrayList();
		
		try {
			con = getCon();
			
			sql="select * from board";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				// 글정보가 있다.
				// 글정보를 한번에 저장하는 객체 (BoardBean)
				// arraylist 한칸에 저장 
				BoardBean bb= new BoardBean();
				
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setPass(rs.getString("pass"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setDate(rs.getDate("date"));
				bb.setIp(rs.getString("ip"));
				bb.setFile(rs.getString("file"));
				
				// bb -> arrayList 한칸 저장
				boardList.add(bb);
			}
			System.out.println(" 게시글 목록 저장 완료 ");
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
	
		return boardList;
	}
	// getBoardList()
	
	// getBoardList(startRow, pageSize)
	
	public List getBoardList(int startRow, int pageSize){
	List boardList = new ArrayList();
		
		try {
			con = getCon();
			// 최신글이 제일 위쪽 위치 
			// 정렬 : 그룹별로 내림차순 (desc), 글순서대로 오름차순(asc)
			// 글 잘라오기 (필요한만큼만 가져오기) (limit(시작행-1,개수))
			
			sql="select * from board "
					+ "order by re_ref desc, "
					+ "re_seq asc "
					+ "limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				// 글정보가 있다.
				// 글정보를 한번에 저장하는 객체 (BoardBean)
				// arraylist 한칸에 저장 
				BoardBean bb= new BoardBean();
				
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setPass(rs.getString("pass"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setDate(rs.getDate("date"));
				bb.setIp(rs.getString("ip"));
				bb.setFile(rs.getString("file"));
				
				// bb -> arrayList 한칸 저장
				boardList.add(bb);
			}
			System.out.println(" 게시글 목록 저장 완료 ");
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
	
		return boardList;
		
		
	}
	
	// getBoardList(startRow, pageSize)
	
	// updateReadcount(num)
	public void updateReadcount(int num){
		
		try {
			con = getCon();
			// 조회수를 1 증가 해당 글만 처리(num) => 수정
			sql ="update board set readcount=readcount+1 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
			System.out.println("조회수 1증가 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
	}
	// updateReadcount(num)
	
	// getBoard(num)
	public BoardBean getBoard(int num){
		
		BoardBean bb = null;
		
		try {
			con = getCon();
			
			sql ="select * from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				bb= new BoardBean();
				
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getDate("date"));
				bb.setFile(rs.getString("file"));
				bb.setIp(rs.getString("ip"));
				bb.setName(rs.getString("name"));
				bb.setNum(rs.getInt("num"));
				bb.setPass(rs.getString("pass"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setSubject(rs.getString("subject"));
				
			}
			System.out.println("글번호에 해당하는 정보 저장완료");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		    closeDB();
		}
		
		return bb;
	}
	// getBoard(num)
	// updateBoard(bb)
	public int updateBoard(BoardBean bb){
		int check=-1;
		try {
			con = getCon();
			sql ="select pass from board where num = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());
			rs = pstmt.executeQuery();
			
			if(bb.getPass() != null){
				if(rs.next()){
					// 글이 있는경우
					// 비밀번호가 맞을경우에만 수정
					System.out.println("입력한 비밀번호 값 = " + bb.getPass());
					System.out.println();
					System.out.println("DB값 가져오기 PASS = " + rs.getString("pass"));
					
						if(bb.getPass().equals(rs.getString("pass"))){
							// 데이터 수정 
							System.out.println("들어옴");
							sql ="update board set name=?,subject=?,content=? where num=?";
							pstmt = con.prepareStatement(sql);
							pstmt.setString(1, bb.getName());
							pstmt.setString(2, bb.getSubject());
							pstmt.setString(3, bb.getContent());
							pstmt.setInt(4, bb.getNum());			
							pstmt.executeUpdate();
							
							check=1;					
						}else{
							//비밀번호 오류
							check=0;
						}
				}else{
				// 글이 없는경우
					check =-1;
				}
			}else{
				check = 0;
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		System.out.println(check);
		return check;
	}
	// updateBoard(bb)
	
	// deleteBoard(num,pass)
	public int deleteBoard(int num,String pass){
		int check =-1;
		
		try {
			con = getCon();
			
			sql ="select pass from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(pass.equals(rs.getString("pass"))){
					sql="delete from board where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					
					pstmt.executeUpdate();
					check=1;					
				}else{
					check=0;
				}
			}else {
				check =-1;
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return check;
	}
	// deleteBoard(num,pass)
	
	// reInsertBoard(bb);
	public void reInsertBoard(BoardBean bb){
		int num=0;
		try {
			con = getCon();
			
			// 글번호 계산
			// DB에 저장된 글번호중 가장 큰값을 가져와서
			//  +1시켜 작성글의 번호를 지정
			
			sql = "select max(num) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1)+1;
			}
			System.out.println("답글 번호 생성 : "+num);
			
			// 답글 순서 재배치
			// re_ref(글번호) / re_seq(글 순서)
			// 변경 처리 : 같은 그룹번호(re_ref) 기존의 글순서보다 큰
			// 글이 있을경우 (re_seq)글 순서 +1 증가
			
			sql = "update board set re_seq = re_seq+1 "
					+ "where re_ref=? and re_seq>?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bb.getRe_ref());
			pstmt.setInt(2, bb.getRe_seq());
			
			pstmt.executeUpdate();
			
			// 답글정보를 저장 (답글쓰기)
			// insert 구문, re_ref(글번호 그대로), 
			// re_seq, re_lev (둘다 +1 씩 증가)
			
			sql="insert into board("
					+ "num,name,pass,subject,content,"
					+ "readcount,re_ref,re_lev,re_seq,"
					+ "date,ip,file) values("
					+ "?,?,?,?,?,?,"
					+ "?,?,?,now(),?,?)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num); // 계산한 글번호값
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getPass());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, 0); // 글 조회수 0
			pstmt.setInt(7, bb.getRe_ref()); // re_ref 답변글 그룹 == 일반글의 글번호와 동일 
			pstmt.setInt(8, bb.getRe_lev()+1); // re_lev 답변글 들여쓰기, 일반글은 들여쓰기 X
			pstmt.setInt(9, bb.getRe_seq()+1); // re_seq 답변글 순서, 일반글 순서가 제일 위쪽
			//pstmt.setDate(10, x); //data 정보는 sql 쿼리에서 now() 내장함수 사용 
			pstmt.setString(10, bb.getIp());
			pstmt.setString(11, bb.getFile());
			
			// 실행
			pstmt.executeUpdate();
			
			System.out.println("게시판 "+bb.getRe_ref()+"번 글 답글 작성 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// reInsertBoard(bb);
	
	
	
	
	
	
	
	

}

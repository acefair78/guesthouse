package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MemberDAO {

	// DB 접근해서 정보를 저장, 수정, 삭제, 조회
	// DAO(Data Access Object)
	
	// 사용레퍼런스 변수 선언
	Connection con= null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// 디비 연결 
		private Connection getCon() throws Exception{
			final String DRIVER = "com.mysql.jdbc.Driver";
			final String DBID = "root"; // jspid
			final String DBPW = "1234"; // jsppass
			final String DBURL = "jdbc:mysql://localhost:3306/jspdb";

			// 1. JDBC 드라이버 로드
			Class.forName(DRIVER);
			// 2. DB 연결
			con = DriverManager.getConnection(DBURL, DBID, DBPW);
			System.out.println("디비연결성공");
			return con;		
		}
		
		// insertMember() 회원가입
		public void insertMember(MemberBean mb){
			
			// 디비 연결 & 드라이버 로드
			
			try {
				con=getCon();
				
				// 3. sql작성 & pstmt 객체생성
				String sql="insert into member(idx,name,gender,age,id,pw,email,reg_date,zonecode,address,detailaddress,extraaddress) values(null,?,?,?,?,?,?,?,?,?,?,?)";
				
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, mb.getName());
				pstmt.setString(2, mb.getGender());
				pstmt.setInt(3, mb.getAge());
				pstmt.setString(4, mb.getId());
				pstmt.setString(5, mb.getPass());
				pstmt.setString(6, mb.getEmail());
				pstmt.setTimestamp(7, mb.getReg_date());
				pstmt.setInt(8, mb.getZonecode());
				pstmt.setString(9, mb.getAddress());
				pstmt.setString(10, mb.getDetailaddress());
				pstmt.setString(11, mb.getExtraaddress());

				pstmt.executeUpdate();
				System.out.println("회원가입완료");
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				// 예외상관없이 항상처리
				// 자원 해제
				if(pstmt != null){
					try {
						pstmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				
				if(con != null){
					try {
						pstmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		
		
		// insertMember() 회원가입
		
		// idCheck(id, pass) 회원체크(로그인)
		public int idCheck(String id, String pass){
			
			int check = -1; // 로그인여부를 체크
			// 디비연결 & 드라이버로드
			try{
				// 1,2단계 디비연결 & 드라이버로드
				con = getCon();
				
				// 3. sql 생성, pstmt 객체 생성
				String sql = "select pw from member where id=?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				
				// 4. 실행
				rs = pstmt.executeQuery();
				
				// 5. 데이터가 있는지 없는지에 따라서 처리
				if(rs.next()){
					// 아이디가 있다
					if(pass.equals(rs.getString("pw"))){
						// 비밀번호 ㅇ
						check = 1;
					}else{
						// 비밀번호 x
						check = 0;
					}
				}else{
					// 아이디가 없다
					check = -1;
				}
				
				System.out.println("로그인 체크 완료 : "+check);
				
			}catch(Exception e){
				e.printStackTrace();
			}
			return check;
			
		}
		// idCheck(id, pass) 회원체크(로그인)
		
		// getMember(id) id 해당하는 정보 가져오는 메서드
		public MemberBean getMember(String id){
			
			MemberBean mb = null;
			
			try {
				con = getCon();
				
				// 3. sql 작성
				String sql="select * from member where id=?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				
				// 4. 실행
				rs = pstmt.executeQuery();
				// 5. 결과처리
				// id에 해당하는 정보를 저장
				// MemberBean 저장
				
				if(rs.next()){
					mb = new MemberBean();
					
					mb.setAge(rs.getInt("age"));
					mb.setEmail(rs.getString("email"));
					mb.setGender(rs.getString("gender"));
					mb.setId(rs.getString("id"));
					mb.setName(rs.getString("name"));
					mb.setPass(rs.getString("pw"));
					mb.setReg_date(rs.getTimestamp("reg_date"));
						
				}
				System.out.println("id 값에 해당하는 정보 확인 완료");
			}catch(Exception e){
				e.printStackTrace();
			}
			return mb;
		}
		// getMember(id) id 해당하는 정보 가져오는 메서드
		
		// updataMember(mb)
		public int updateMember(MemberBean mb){
			int check = 0;
			
			try {
				// 드라이버로드 & 디비연결
				con = getCon();
				
				// sql 작성 pstmt객체 생성
				String sql="select pw from member where id=?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, mb.getId());
				
				rs = pstmt.executeQuery();
				
				// 동작
				if(rs.next()){
					if(mb.getPass().equals(rs.getString("pw"))){
						
						// 본인인증 완료후 회원정보 수정
						sql="update member set name=?, age=?, gender=?, email=? where id=?";

						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, mb.getName());
						pstmt.setInt(2, mb.getAge());
						pstmt.setString(3, mb.getGender());
						pstmt.setString(4, mb.getEmail());
						pstmt.setString(5, mb.getId());
						
						pstmt.executeUpdate();
						check = 1;
						
					}else{
						check = 0;	// 비밀번호 오류
					}
				}else{
					check=-1;	// 아이디없음
				}
						
			} catch (Exception e) {
				e.printStackTrace();
			} finally{
				
				try {
					if (rs != null) {
						rs.close();
					}
					if(pstmt != null){
						pstmt.close();
					}
					if(con != null){
						con.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
			}
			
			
			
			return check;
		}
		// updateMember(mb)
		
		// deleteMember(id, pass)
			public int deleteMember(String id, String pass){
				int check = -1;
				
				try {
					con = getCon();
					
					String sql="select pw from member where id=?";
					
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, id);
					rs = pstmt.executeQuery();
					
					if(rs.next()){
						if(pass.equals(rs.getString("pw"))){
							sql="delete from member where id=?";
							pstmt = con.prepareStatement(sql);
							pstmt.setString(1, id);
							
							pstmt.executeUpdate();
							
							check = 1;
						}else{
							check = 0;
						}
					}else{
						check = -1;
					}
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				
				return check;
			}
		// deleteMember(id, pass)

		// getMemberList()
		public List<MemberBean> getMememberList(){
			List<MemberBean> memberList = new ArrayList<MemberBean>();
			// ArrayList memberList = new ArrayList();

			try {
				con = getCon();
				String sql = "select * from member";
				
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					// 한사람의 정보를 저장 객체
					MemberBean mb = new MemberBean();
					mb.setAge(rs.getInt("age"));
					mb.setEmail(rs.getString("email"));
					mb.setGender(rs.getString("gender"));
					mb.setId(rs.getString("id"));
					mb.setName(rs.getString("name"));
					mb.setPass(rs.getString("pw"));
					mb.setReg_date(rs.getTimestamp("reg_date"));
					
					// 한명의 정보(MembrBean)가 ArrayList 한칸에 저장
					memberList.add(mb);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally{
				
				try {
					if (rs != null) {
						rs.close();
					}
					if(pstmt != null){
						pstmt.close();
					}
					if(con != null){
						con.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			
			return memberList;
			
		}
		// getMemberList()
		
		// joinIdCheck()
		
				public int joinIdCheck(String id){
					int check=0;
					
					try {
						// 1&2 드라이버로드, 디비연결
						con= getCon();
						// id가 있는지 없는지 판단 (id값= pk , uk)
						String sql="select * from member where id=?";
						
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, id);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()){
							// id가 존재한다(중복)
							check = 1;
						}else{
							// id값이 없다(사용가능)
							check = 0;
						}
						System.out.println("ID 중복체크 완료"+check);
						
					} catch (Exception e) {
						e.printStackTrace();
					}finally{
						// 자원해제
						try {
							if (rs != null) {
								rs.close();
							}
							if(pstmt != null){
								pstmt.close();
							}
							if(con != null){
								con.close();
							}
						} catch (SQLException e) {
							e.printStackTrace();
						}
					}
					return check;
				}
				
				// joinIdCheck()

		
}

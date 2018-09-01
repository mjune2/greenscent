package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

public class DiaryDAO {
	private static DiaryDAO dao=new DiaryDAO();
	private DataSource dataSource;
	private DiaryDAO() {
		dataSource=DataSourceManager.getInstance().getDataSource();
	}
	public static DiaryDAO getInstance() {
		return dao;
	}
	public Connection getConnection() throws SQLException {
		return dataSource.getConnection();
	}
	public void closeAll(PreparedStatement pstmt,Connection con) throws SQLException {
		if(pstmt!=null)
			pstmt.close();
		if(con!=null)
			con.close();
	}
	public void closeAll(ResultSet rs,PreparedStatement pstmt,Connection con) throws SQLException {
		if(rs!=null)
			rs.close();
		closeAll(pstmt, con);
	}
	public void registerDiary(DiaryVO dvo) throws SQLException {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try{
			con=getConnection();
			String sql="insert into diary(dno,id,title,content,regdate,isPublic)"
			+" values(dno_seq.nextval,?,?,?,sysdate,?)";			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, dvo.getVo().getId());
			pstmt.setString(2, dvo.getTitle() );
			pstmt.setString(3, dvo.getContent());
			pstmt.setInt(4,dvo.getSecretYN());
			pstmt.executeUpdate();			
			pstmt.close();
			pstmt=con.prepareStatement("select dno_seq.currval from dual");
			rs=pstmt.executeQuery();
			if(rs.next())
			dvo.setDno(rs.getInt(1));			
		}finally{
			closeAll(rs,pstmt,con);
		}
	}
	public ArrayList<DiaryVO> getMyDiaryList(PagingBean pb,String id) throws SQLException{
		ArrayList<DiaryVO> list=new ArrayList<DiaryVO>();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try{
			con=getConnection(); 
			String sql="select d.dno,d.title,d.regdate\r\n" + 
					"from (SELECT row_number() over(ORDER BY dno DESC) as rnum,dno,id,title," + 
					"to_char(regdate,'YYYY.MM.DD') as regdate\r\n" + 
					"FROM diary where id=?\r\n" + 
					") d where rnum between ? and ?\r\n" + 
					"order by dno desc";
			pstmt=con.prepareStatement(sql);	
			pstmt.setString(1,id);
			pstmt.setInt(2, pb.getStartRowNumber());
			pstmt.setInt(3, pb.getEndRowNumber());
			rs=pstmt.executeQuery();	
			//목록에서 게시물 content는 필요없으므로 null로 setting
			//select no,title,time_posted,hits,id,name
			while(rs.next()){		
				DiaryVO dvo=new DiaryVO();
				dvo.setDno(rs.getInt(1));
				dvo.setTitle(rs.getString(2));
				dvo.setRegDate(rs.getString(3));
				list.add(dvo);
			}			
		}finally{
			closeAll(rs,pstmt,con);
		}
		return list;
	} 
}

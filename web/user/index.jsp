<%@page import="entities.Student"%>
<%@page import="daoImp.StudentDaoImp"%>
<%@page import="entities.SjoinT"%>
<%@page import="daoImp.TeacherDaoImp"%>
<%@page import="entities.Teacher"%>
<%@page import="entities.Subject"%>
<%@page import="daoImp.SubjectDaoImp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Subject</title>
        <jsp:include page="../static/head_tag.jsp" />
    </head>
    <body style="background-color: #FFFFFF;">
        <c:if test="${username != null}">
        <jsp:include page="../static/nav_bar.jsp" />
        <center> 
        <div class="container">
           <h1>จัดการ รายวิชา</h1><br>
             <table class="table table-bordered" align="center">
                <tr class="success">
                    <th><center>รหัสวิชา</center></th>
                    <th width="300"><center>ชื่อรายวิชา</center></th>
                    
                    <th width="147"><center>ชื่ออาจารย์ผู้สอน</center></th>
                    <th ><center>เพิ่ม นักศึกษา</center></th>       
                    <th ><center>แก้ไข รายวิชา</center></th>   
                    <th ><center>ลบ รายวิชา</center></th>           
                    <th ><center>เช็คชื่อ นักศึกษา</center></th>
                    <th ><center>ออกรายงาน</center></th>
                </tr>
                <%  
                    //Get Subject
                    SubjectDaoImp subjectDao = new SubjectDaoImp();
                    List<SjoinT> listSubject = new ArrayList();
                    listSubject = subjectDao.getAllSubjectJoin();
                    session.setAttribute("listSubject", listSubject);
                    //Get Student
                    StudentDaoImp studentDao = new StudentDaoImp();
                    List<Student> listStudent = new ArrayList();
                    listStudent = studentDao.getAllStudent();
                    session.setAttribute("listStudent", listStudent);
                %>
                <c:forEach var="sub" items="${listSubject}" >
                <tr>
                    <td>
                      <center>
                           ${sub.subjectId}
                      </center>
                    </td>
                    <td>
                       <center>
                           ${sub.subjectName}
                       </center>
                    </td>
                    
                    <td>
                        <center>
                          ${sub.fullName}
                        </center>
                    </td>
                    <td>
                       <center>
                            <a href="${pageContext.request.contextPath}/user/addStudent.jsp?subjectId=${sub.subjectId}&subjectName=${sub.subjectName}" >
                                <button  class="btn btn-success"><span class='glyphicon glyphicon-plus'></span></button>
                            </a>
                       </center>
                    </td>
                    <td>
                      <center>
                            <button  data-toggle="modal" data-target="#editModal${sub.subjectId}" class="btn btn-warning"><span class='glyphicon glyphicon-edit'></span></button>
                      </center>
                            <!-------- popup edit --------->
                            
                            <div id="editModal${sub.subjectId}" class="modal fade" role="dialog">
                              <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        <h4 class="modal-title">แก้ไขรายวิชา</h4>
                                    </div>
                                    <form action="${pageContext.request.contextPath}/SubjectController?action=update" method="POST">
                                        <div class="modal-body">
                                            <div class="form-group">
                                                <input type="hidden" name="edit_subject_code" value="${sub.subjectId}" />
                                                <label style="text-align: left" for="edit_subject_code">รหัสวิชา :</label>
                                                <input type="text" id="edit_subject_code" name="edit_subject_code" value="${sub.subjectId}" class="form-control" disabled/>
                                            </div>
                                            <div class="form-group">
                                                <label for="edit_subject_name">ชื่อรายวิชา :</label>
                                                <input type="text" id="edit_subject_name" name="edit_subject_name" value="${sub.subjectName}" class="form-control" required="required">
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-danger" data-dismiss="modal">ยกเลิก</button>
                                            <input id="btnEdit" type="submit" class="btn btn-success" value="แก้ไข">
                                        </div>
                                    </form>
                                </div>
                              </div>
                            </div>
                            <!---------- popup edit -------> 
                       </center>
                    </td>
                      <td>
                       <center>
                           <form action="${pageContext.request.contextPath}/SubjectController?action=delete&subject_code=${sub.subjectId}" method="POST">
                               <button type="submit" class="btn btn-danger"><span class='glyphicon glyphicon-remove'></span></button>
                            </form>
                       </center>
                    </td>
                    <td>
                       <center>
                            <a href="${pageContext.request.contextPath}/user/checkStudent.jsp?subjectId=${sub.subjectId}&subjectName=${sub.subjectName}" >
                                <button  class="btn btn-info"><span class='glyphicon glyphicon-check'></span></button>
                            </a>
                       </center>
                    </td>
                    <td>
                       <center>
                            <form action="Report/index.jsp" method="POST">
                                <input type="hidden" name="subject" value="${sub.subjectName}">
                                <button type='submit' class="btn btn-default">
                                    <span class='glyphicon glyphicon-print'></span></button>
                            </form>
                       </center>
                    </td>
                </tr>
                </c:forEach>
            </table>
            <br><br>
            <button type="button" class="btn btn-default" data-toggle="modal" data-target="#addModal"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;เพิ่มรายวิชา</button>
            </center>
            <!-------- popup add --------->
            <div id="addModal" class="modal fade" role="dialog">
              <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">เพิ่มรายวิชา</h4>
                    </div>
                    <form action="${pageContext.request.contextPath}/SubjectController?action=add" method="POST">
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="subject_code">รหัสวิชา :</label>
                                <input type="text" id="subject_code" name="subject_code" class="form-control" required="required">
                            </div>
                            <div class="form-group">
                                <label for="subject_name">ชื่อรายวิชา :</label>
                                <input type="text" id="subject_name" name="subject_name" class="form-control" required="required">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">ยกเลิก</button>
                            <input id="btnAdd" type="submit" class="btn btn-success" value="เพิ่ม">
                        </div>
                    </form>
                </div>
              </div>
            </div>
           <!---------- popup add -------> 
        </div>
        </div>   
        </c:if>
        <c:if test="${username == null}">
            <jsp:forward page="../login.jsp"></jsp:forward>
        </c:if>
    </body>
</html>

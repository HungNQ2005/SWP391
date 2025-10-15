/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;



import dao.PerformersDAO;
import java.util.List;
import model.Performers;




/**
 *
 * @author Vo Thi Phi Yen - CE190428
 */
public class DBTest {

    public static void main(String[] args) {
    PerformersDAO dao = new PerformersDAO();
        List<Performers> product = dao.getAllPerformers();
        for (Performers products : product) {
            System.out.println(products);
        }  
    }
}

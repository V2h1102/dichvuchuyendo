package com.assignment.furniture_moving_service_swp391.controller;

import com.assignment.furniture_moving_service_swp391.dao.ItemDAO;
import com.assignment.furniture_moving_service_swp391.dao.ItemCategoryDAO;
import com.assignment.furniture_moving_service_swp391.model.Item;
import com.assignment.furniture_moving_service_swp391.model.ItemCategory;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ItemController extends HttpServlet {

    private final ItemDAO itemDAO = new ItemDAO();
    private final ItemCategoryDAO categoryDAO = new ItemCategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add":
                // Hiển thị form thêm Item
                List<ItemCategory> categories = categoryDAO.getAllCategories();
                request.setAttribute("categories", categories);
                RequestDispatcher rdAdd = request.getRequestDispatcher("/views/add-item.jsp");
                rdAdd.forward(request, response);
                break;

            case "edit":
                long editId = Long.parseLong(request.getParameter("id"));
                Item editItem = itemDAO.getItemById(editId);
                request.setAttribute("item", editItem);
                request.setAttribute("categories", categoryDAO.getAllCategories());
                RequestDispatcher rdEdit = request.getRequestDispatcher("/views/edit-item.jsp");
                rdEdit.forward(request, response);
                break;

            case "delete":
                long deleteId = Long.parseLong(request.getParameter("id"));
                itemDAO.deleteItem(deleteId);
                response.sendRedirect("ItemController");
                break;

            default:
                // ✅ Hiển thị danh sách Item có hỗ trợ search và filter
                String search = request.getParameter("search");
                String status = request.getParameter("statusFilter");

                List<Item> list;
                if ((search != null && !search.trim().isEmpty()) ||
                        (status != null && !status.trim().isEmpty())) {
                    list = itemDAO.searchItems(search, status);
                } else {
                    list = itemDAO.getAllItems();
                }

                request.setAttribute("list", list);
                RequestDispatcher rdList = request.getRequestDispatcher("/views/manage-item.jsp");
                rdList.forward(request, response);
                break;
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) action = "insert";

        switch (action) {
            case "insert":
                try {
                    String name = request.getParameter("name");
                    String description = request.getParameter("description");
                    long categoryId = Long.parseLong(request.getParameter("category_id"));
                    double price = Double.parseDouble(request.getParameter("price"));
                    String status = request.getParameter("status");

                    Item newItem = new Item(0, name, description, categoryId, price, status);
                    itemDAO.insertItem(newItem);
                    response.sendRedirect("ItemController");
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Failed to insert item: " + e.getMessage());
                    request.getRequestDispatcher("/views/add-item.jsp").forward(request, response);
                }
                break;

            case "update":
                try {
                    long id = Long.parseLong(request.getParameter("id"));
                    String nameU = request.getParameter("name");
                    String descriptionU = request.getParameter("description");
                    long categoryIdU = Long.parseLong(request.getParameter("category_id"));
                    double priceU = Double.parseDouble(request.getParameter("price"));
                    String statusU = request.getParameter("status");

                    Item updateItem = new Item(id, nameU, descriptionU, categoryIdU, priceU, statusU);
                    itemDAO.updateItem(updateItem);
                    response.sendRedirect("ItemController");
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Failed to update item: " + e.getMessage());
                    request.getRequestDispatcher("/views/edit-item.jsp").forward(request, response);
                }
                break;
        }
    }
}

from sqlalchemy import Column, Integer, String, ForeignKey, DECIMAL, JSON, ARRAY
from sqlalchemy.orm import relationship
from sqlalchemy.dialects.postgresql import JSONB
from .database import Base

class Role(Base):
    __tablename__ = "roles"
    role_id = Column(Integer, primary_key=True)
    role_name = Column(String(50), unique=True, nullable=False)
    users = relationship("User", back_populates="role")

class User(Base):
    __tablename__ = "users"
    user_id = Column(Integer, primary_key=True)
    role_id = Column(Integer, ForeignKey("roles.role_id"), nullable=False)
    username = Column(String(100), unique=True, nullable=False)
    password_hash = Column(String(255), nullable=False)
    role = relationship("Role", back_populates="users")

class RestaurantTable(Base):
    __tablename__ = "restaurant_tables"
    table_id = Column(Integer, primary_key=True)
    table_number = Column(Integer, unique=True, nullable=False)
    status = Column(String(50), nullable=False, default='Available')
    orders = relationship("Order", back_populates="table")

class MenuCategory(Base):
    __tablename__ = "menu_categories"
    category_id = Column(Integer, primary_key=True)
    name = Column(String(100), nullable=False)
    items = relationship("MenuItem", back_populates="category")

class MenuItem(Base):
    __tablename__ = "menu_items"
    item_id = Column(Integer, primary_key=True)
    category_id = Column(Integer, ForeignKey("menu_categories.category_id"), nullable=False)
    name = Column(String(150), nullable=False)
    description = Column(String)
    price = Column(DECIMAL(10, 2), nullable=False)
    image_url = Column(String(255))
    customization_options = Column(JSONB)
    allergen_info = Column(ARRAY(String))
    category = relationship("MenuCategory", back_populates="items")

class Order(Base):
    __tablename__ = "orders"
    order_id = Column(Integer, primary_key=True)
    table_id = Column(Integer, ForeignKey("restaurant_tables.table_id"), nullable=False)
    status = Column(String(50), nullable=False, default='Received')
    table = relationship("RestaurantTable", back_populates="orders")
    items = relationship("OrderItem", back_populates="order")

class OrderItem(Base):
    __tablename__ = "order_items"
    order_item_id = Column(Integer, primary_key=True)
    order_id = Column(Integer, ForeignKey("orders.order_id"), nullable=False)
    item_id = Column(Integer, ForeignKey("menu_items.item_id"), nullable=False)
    quantity = Column(Integer, nullable=False)
    customizations = Column(JSONB)
    order = relationship("Order", back_populates="items")
    item = relationship("MenuItem")